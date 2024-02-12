local M = {}

local python_path = os.getenv("HOMEBREW_PREFIX") .. "/bin/python3"

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
