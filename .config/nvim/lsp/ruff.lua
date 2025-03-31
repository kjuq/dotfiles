-- TODO: not sure whether `settings` is working or not
local settings = {
	lint = {
		ignore = { 'E741' },
	},
}

return {
	cmd = { 'ruff', 'server' },
	filetypes = { 'python' },
	root_markers = {'pyproject.toml', 'ruff.toml', '.ruff.toml'},
	single_file_support = true,
	settings = settings,
}
