local settings = {
	-- https://github.com/astral-sh/ruff-lsp/issues/384#issuecomment-2038623937
	pyright = {
		disableOrganizeImports = true,
		disableTaggedHints = true,
	},
	python = {
		analysis = {
			-- ignore = { '*' },
			-- typeCheckingMode = 'off',
			diagnosticMode = 'workspace',
			diagnosticSeverityOverrides = {
				-- https://github.com/microsoft/pyright/blob/main/docs/configuration.md#type-check-diagnostics-settings
				-- Disable diagnostics that conflict with **Ruff and mypy**
				reportUndefinedVariable = false, -- `F821` of Ruff
				reportPossiblyUnboundVariable = false, -- `F821` of Ruff
				reportAssignmentType = false, -- `list-item` of mypy
				reportAttributeAccessIssue = false, -- `attr-defined` of mypy
				-- reportMissingImports = false, -- `import-not-found` of mypy
			},
		},
	},
}

return {
	cmd = { 'pyright-langserver', '--stdio' },
	root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json" },
	filetypes = { 'python' },
	settings = settings,
}

