local settings = {
	pylsp = {
		plugins = {
			autopep8 = { enabled = false }, -- format
			flake8 = { enabled = false },
			jedi = { enabled = false },
			mccabe = { enabled = false }, -- lint (contained to flake8)
			pycodestyle = { enabled = false }, -- lint (contained to flake8)
			pydocstyle = { enabled = false },
			pylint = { enabled = false },
			pyflakes = { enabled = false }, -- lint (contained to flake8)
			rope_autoimport = { enabled = false }, -- refactoring tool
			yapf = { enabled = false }, -- format
		},
	},
}

---@type vim.lsp.Config
return {
	settings = settings,
}
