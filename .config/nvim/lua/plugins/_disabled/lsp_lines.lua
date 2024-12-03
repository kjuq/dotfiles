---@type LazySpec
local spec = { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' }

spec.keys = {
	{
		'<Space>Ll',
		mode = { 'n' },
		function()
			require('lsp_lines').toggle()
		end,
		'LspLines: Toggle lsp_[l]ines',
	},
}

spec.opts = function()
	vim.diagnostic.config({
		virtual_text = false,
		virtual_lines = {
			only_current_line = true,
			highlight_whole_line = false,
		},
	})
	-- disables on load
	require('lsp_lines').toggle()
	return {}
end

return spec
