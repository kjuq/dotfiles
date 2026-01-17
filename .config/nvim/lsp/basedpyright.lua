local settings = {
	-- https://github.com/astral-sh/ruff-lsp/issues/384#issuecomment-2038623937
	basedpyright = {
		analysis = {
			ignore = { '*' },
			typeCheckingMode = 'off',
		},
	},
}

---@type vim.lsp.Config
return {
	settings = settings,
}
