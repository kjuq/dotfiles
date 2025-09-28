local lua = {
	-- {
	-- 	rootMarkers = { 'stylua.toml', '.stylua.toml' },
	-- 	formatCanRange = true,
	-- 	formatCommand = 'stylua --search-parent-directories ${--range-start=charStart} ${--range-end=charEnd} -',
	-- 	formatStdin = true,
	-- },
	-- {
	-- 	lintSource = 'efm/luacheck',
	-- 	lintCommand = 'luacheck --codes --no-color --globals vim -- -',
	-- 	lintIgnoreExitCode = true,
	-- 	lintStdin = true,
	-- 	lintAfterOpen = true,
	-- 	lintFormats = { '%.%#:%l:%c: (%t%n) %m' },
	-- 	rootMarkers = { '.luacheckrc' },
	-- },
}
local c = {
	{
		-- range-formatting is not supported probably
		formatCommand = 'uncrustify -c "$UNCRUSTIFY_CONFIG" -q --assume "${INPUT}"',
		formatStdin = true,
		formatCanRange = false,
	},
	{
		-- TODO: range using `--lines`
		formatCommand = 'clang-format --assume-filename="${INPUT}" --fallback-style=none -',
		formatStdin = true,
		formatCanRange = true,
	},
}
local python = {
	{
		lintSource = 'efm/mypy',
		lintCommand = 'mypy --show-column-numbers --strict --strict-equality --shadow-file ${INPUT} <(cat) ${INPUT}',
		lintAfterOpen = true,
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
}

local sh = {
	{
		formatCommand = 'shfmt -',
		formatStdin = true,
		formatCanRange = false,
	},
}

local settings = {
	lintDebounce = '0.5s',
	formatDebounce = '0.5s',
	languages = {
		lua = lua,
		sh = sh,
		python = python,
		c = c,
		cpp = c,
	},
}

---@type table<string>
local langs = {}
for lang, _ in pairs(settings.languages) do
	langs[#langs + 1] = lang
end

---@type vim.lsp.Config
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
	filetypes = langs,
}
