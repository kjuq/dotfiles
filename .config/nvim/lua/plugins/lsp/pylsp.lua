local M = {}

local default_path = vim.system({ "which", "python" }):wait().stdout
local path = vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV .. "/bin/python3" or default_path

M.opts = {
	settings = {
		pylsp = {
			plugins = {
				jedi = {
					environment = path,
				},
			},
		},
	},
}

return M
