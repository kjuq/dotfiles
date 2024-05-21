local M = {}

local python_path = vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV or vim.env.HOMEBREW_PREFIX
python_path = python_path .. "/bin/python3"

M.opts = {
	settings = {
		pylsp = {
			plugins = {
				jedi = {
					environment = python_path,
				},
			},
		},
	},
}

return M
