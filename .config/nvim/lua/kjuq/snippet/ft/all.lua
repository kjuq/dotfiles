local M = {}

---@type kjuq.snippet.snippet[]
M.snippets = {
	{
		trigger = 'date',
		body = function()
			return os.date('%Y-%m-%d') --[[@ as string]]
		end,
	},
	{
		trigger = 'time',
		body = function()
			return os.date('%H:%M:%S') --[[@ as string]]
		end,
	},
	{
		trigger = 'shebang',
		body = '#!/usr/bin/env ${0}',
	},
	{
		trigger = 'list',
		body = {
			[[hello, ${1}]],
			[[world, ${2}]],
		},
	},
}

return M
