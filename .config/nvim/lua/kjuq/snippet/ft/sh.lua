local M = {}

M.snippets = {
	scriptDir = [[script_dir="\$( cd -- "\$( dirname -- "\${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"]],
	scriptName = [[script_name="$(basename "$0")"]],
}

return M
