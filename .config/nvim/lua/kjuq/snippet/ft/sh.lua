local M = {}

M.snippets = {
	{
		trigger = 'scriptDir',
		body = [[script_dir="\$( cd -- "\$( dirname -- "\${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"]],
	},
	{
		trigger = 'scriptName',
		body = [[script_name="$(basename "$0")"]],
	},
}

return M
