---@type vim.lsp.Config
return {
	cmd = {
		'fish-lsp',
		'start',
		'--disable',
		'formatting', -- Indentation with tab is not currently supported
	},
}
