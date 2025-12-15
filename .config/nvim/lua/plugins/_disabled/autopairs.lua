---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/windwp/nvim-autopairs' }
spec.event = 'InsertEnter'

spec.opts = {
	map_cr = false,
	map_c_h = true,
	map_c_w = true,
	break_undo = false,
	check_ts = true, -- treesitter
	fast_wrap = {
		map = '<C-g>e',
		keys = 'arstneioghwfpluy',
	},
}

return spec
