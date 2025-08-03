local M = {}

M.snippets = {
	{
		trigger = 'scriptdir',
		body = [[script_dir="\$( cd -- "\$( dirname -- "\${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"]],
	},
	{
		trigger = 'scriptname',
		body = [[script_name="$(basename "$0")"]],
	},
}

return M
