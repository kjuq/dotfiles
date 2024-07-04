local M = {}

M.opts = {
	settings = {
		pylsp = {
			plugins = {
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
