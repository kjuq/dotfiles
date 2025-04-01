local settings = {
	lintDebounce = '0.1s',
	languages = {
		lua = {
			{
				rootMarkers = { 'stylua.toml', '.stylua.toml' },
				formatCanRange = true,
				formatCommand = 'stylua --search-parent-directories -',
				formatStdin = true,
			},
			{
				lintSource = 'efm/luacheck',
				lintCommand = 'luacheck --codes --no-color --globals vim -- -',
				lintIgnoreExitCode = true,
				lintStdin = true,
				lintAfterOpen = true,
				lintOnSave = false,
				lintFormats = { '%.%#:%l:%c: (%t%n) %m' },
				rootMarkers = { '.luacheckrc' },
			},
		},
		sh = {
			{
				formatCommand = 'shfmt -',
				formatStdin = true,
			},
		},
		python = {
			{
				lintSource = 'efm/mypy',
				lintCommand = 'mypy --show-column-numbers --strict --strict-equality --shadow-file ${INPUT} <(cat) ${INPUT}',
				lintAfterOpen = true,
				lintIgnoreExitCode = true,
				lintStdin = true,
				lintFormats = {
					'%.%#:%l:%c: %trror: %m',
					'%.%#:%l:%c: %tarning: %m',
					'%.%#:%l:%c: %tote: %m',
				},
				rootMarkers = {
					'mypy.ini',
					'pyproject.toml',
					'setup.cfg',
				},
			},
		},
	},
}

return {
	cmd = { 'efm-langserver' },
	root_markers = { '.git' },
	single_file_support = true,
	init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
		-- codeAction = true,
	},
	settings = settings,
	filetypes = { 'lua', 'python', 'go' },
}
