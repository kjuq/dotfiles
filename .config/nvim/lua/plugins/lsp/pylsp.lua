local M = {}

local default_path = vim.system({ "which", "python" }):wait().stdout
local path = vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV .. "/bin/python3" or default_path

M.opts = {
	settings = {
		pylsp = {
			plugins = {
				jedi = { environment = path },
				pycodestyle = { enabled = false }, -- lint (contained to flake8)
				pylint = { enabled = false },
				mccabe = { enabled = false }, -- lint (contained to flake8)
				pyflakes = { enabled = false }, -- lint (contained to flake8)
				flake8 = { enabled = false },
				pydocstyle = { enabled = false },
				autopep8 = { enabled = false }, -- format
				yapf = { enabled = false }, -- format
			},
		},
	},
}

return M
