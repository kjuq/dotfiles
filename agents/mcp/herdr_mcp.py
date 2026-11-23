#!/usr/bin/env -S uv run --script

# /// script
# requires-python = ">=3.12"
# dependencies = ["mcp==2.3.0"]
# ///

import json
import os
import re
import subprocess
from typing import Any, Literal
from uuid import UUID

from mcp.server import MCPServer
from mcp.server.mcpserver.exceptions import ToolError


mcp = MCPServer("herdr")
AgentKind = Literal["codex", "claude"]
AgentStatus = Literal["idle", "working", "blocked", "done", "unknown"]


def herdr_text(*args: str, timeout: float = 30) -> str:
	try:
		result = subprocess.run(
			["herdr", *args], capture_output=True, text=True, timeout=timeout,
			check=False,
		)
	except (OSError, subprocess.TimeoutExpired) as error:
		raise ToolError(str(error)) from error
	if result.returncode != 0:
		raise ToolError((result.stderr or result.stdout).strip())
	return result.stdout


def herdr(*args: str, timeout: float = 30) -> dict[str, Any]:
	return json.loads(herdr_text(*args, timeout=timeout))["result"]


@mcp.tool()
def list_agents() -> dict[str, Any]:
	"""List live agents with pane IDs, names, and status."""
	return herdr("agent", "list")


@mcp.tool()
def get_agent(target: str) -> dict[str, Any]:
	"""Show a live agent by name or pane ID."""
	return herdr("agent", "get", target)


@mcp.tool()
def list_panes() -> dict[str, Any]:
	"""List Herdr panes and their current working directories and agents."""
	return herdr("pane", "list")


@mcp.tool()
def prompt_agent(
	target: str, text: str, wait: bool = False, timeout_ms: int = 120000,
) -> dict[str, Any]:
	"""Submit a prompt to a live agent and optionally wait for it to settle."""
	args = ["agent", "prompt", target, text]
	if wait:
		args += ["--wait", "--timeout", str(timeout_ms)]
	timeout = timeout_ms / 1000 + 5 if wait else 30
	return herdr(*args, timeout=timeout)


@mcp.tool()
def wait_agent(
	target: str, until: list[AgentStatus] | None = None, timeout_ms: int = 60000,
) -> dict[str, Any]:
	"""Wait for a live agent to reach the given status, or to settle by default."""
	args = ["agent", "wait", target, "--timeout", str(timeout_ms)]
	for status in until or []:
		args += ["--until", status]
	return herdr(*args, timeout=timeout_ms / 1000 + 5)


def require_agent(target: str, kind: AgentKind) -> dict[str, Any]:
	agent = get_agent(target)["agent"]
	if agent["agent"] != kind:
		raise ToolError(f"{target} is not a {kind} agent")
	return agent


def start_agent(
	kind: AgentKind, name: str, pane: str, session_id: UUID | None,
	split: Literal["right", "down"] | None,
) -> dict[str, Any]:
	if os.environ.get("HERDR_ENV") != "1":
		raise ToolError("Start agents from a Herdr-managed session")
	if not re.fullmatch(r"[a-z][a-z0-9_-]{0,31}", name):
		raise ToolError("Use a unique name with 1-32 lowercase letters, digits, hyphens or underscores, starting with a letter")
	if not re.fullmatch(r"w[0-9A-Za-z]+:p[0-9A-Za-z]+", pane):
		raise ToolError("Use a pane ID from list_panes")

	if split is not None:
		agent = require_agent(pane, kind)
		cwd = agent.get("foreground_cwd") or agent.get("cwd")
		if not cwd:
			raise ToolError(f"Could not determine the working directory of {pane}")
		if any(agent.get("name") == name for agent in list_agents()["agents"]):
			raise ToolError(f"Agent name already in use: {name}")
		result = herdr("pane", "split", pane, "--direction", split, "--cwd", cwd, "--no-focus")
		pane = result["pane"]["pane_id"]

	args = ["agent", "start", name, "--kind", kind, "--pane", pane]
	if session_id is not None:
		resume = "resume" if kind == "codex" else "--resume"
		args += ["--", resume, str(session_id)]
	try:
		return herdr(*args, timeout=40)
	except ToolError as error:
		raise ToolError(f"{kind} start in {pane}: {error}. Check the pane before retrying.") from error


@mcp.tool()
def start_codex(
	name: str,
	pane: str,
	session_id: UUID | None = None,
	split: Literal["right", "down"] | None = None,
) -> dict[str, Any]:
	"""Start Codex in an idle shell pane, or resume a saved Codex session by UUID.

	Use list_panes to find the pane ID. To create a sibling of a running Codex
	pane, pass that ID and a split direction. The sibling keeps the same
	working directory and does not take focus.
	"""
	return start_agent("codex", name, pane, session_id, split)


@mcp.tool()
def start_claude(
	name: str,
	pane: str,
	session_id: UUID | None = None,
	split: Literal["right", "down"] | None = None,
) -> dict[str, Any]:
	"""Start Claude Code in an idle shell pane, or resume a local session by UUID.

	Use list_panes to find the pane ID. Pass a Claude Code pane ID and a
	split direction to create a sibling in the same directory without taking focus.
	"""
	return start_agent("claude", name, pane, session_id, split)


def read_agent(target: str, kind: AgentKind, lines: int) -> str:
	if not 1 <= lines <= 200:
		raise ToolError("lines must be between 1 and 200")
	require_agent(target, kind)
	return herdr_text("agent", "read", target, "--source", "recent-unwrapped", "--lines", str(lines))


@mcp.tool()
def read_codex(target: str, lines: int = 80) -> str:
	"""Read recent terminal output from a Codex agent by name or pane ID."""
	return read_agent(target, "codex", lines)


@mcp.tool()
def read_claude(target: str, lines: int = 80) -> str:
	"""Read recent terminal output from a Claude Code agent by name or pane ID."""
	return read_agent(target, "claude", lines)


def quit_agent(target: str, kind: AgentKind) -> dict[str, Any]:
	caller = os.environ.get("HERDR_PANE_ID")
	if os.environ.get("HERDR_ENV") != "1" or not caller:
		raise ToolError("Quit agents from a Herdr-managed session")
	agent = require_agent(target, kind)
	if agent["pane_id"] == require_agent(caller, kind)["pane_id"]:
		raise ToolError("Cannot quit the session making this request")
	if agent["agent_status"] not in {"idle", "done"}:
		raise ToolError(f"Wait for {target} to become idle before quitting")
	command = "/quit" if kind == "codex" else "/exit"
	return herdr("agent", "prompt", target, command)


@mcp.tool()
def quit_codex(target: str) -> dict[str, Any]:
	"""Send /quit to an idle or done Codex agent, leaving its pane and saved session intact."""
	return quit_agent(target, "codex")


@mcp.tool()
def quit_claude(target: str) -> dict[str, Any]:
	"""Send /exit to an idle or done Claude Code agent, leaving its pane and saved session intact."""
	return quit_agent(target, "claude")


if __name__ == "__main__":
	mcp.run()
