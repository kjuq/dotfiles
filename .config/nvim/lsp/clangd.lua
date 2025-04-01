return {
	cmd = { 'clangd', '--background-index' },
	root_markers = { 'compile_commands.json', 'compile_flags.txt' },
	filetypes = { 'c', 'cpp' },
	init_options = {
		documentFormatting = false,
		documentRangeFormatting = false,
	},
	-- on_attach = function(client, _)
	-- 	-- Disable format capability
	-- 	client.server_capabilities.documentFormattingProvider = false
	-- 	client.server_capabilities.documentOnTypeFormattingProvider = false
	-- 	client.server_capabilities.documentRangeFormattingProvider = false
	-- end,
}
