---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/echasnovski/mini.nvim' }

spec.keys = {
	{ 'ga', mode = { 'n', 'x' } }, -- for align
	{ 'gA', mode = { 'n', 'x' } }, -- for align
}

spec.config = function()
	require('mini.align').setup({
		-- Module mappings. Use `''` (empty string) to disable one.
		mappings = {
			start = 'ga',
			start_with_preview = 'gA',
		},
	})
end

return spec
