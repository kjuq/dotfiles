---@type LazySpec
local spec = { 'folke/which-key.nvim' }
spec.event = 'VeryLazy'

spec.cmd = {
	'WhichKey',
}

spec.opts = {
	preset = 'modern',
	win = {
		no_overlap = false,
		border = 'single',
	},
	keys = {
		scroll_down = require('utils.common').floatscrolldown,
		scroll_up = require('utils.common').floatscrollup,
	},
	layout = {
		width = { max = 80 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = 'left', -- align columns left, center or right
	},
}

spec.config = function(_, opts)
	local wk = require('which-key')
	wk.add({
		{ '<Space>a', group = 'Additional' },
		{ '<Space>b', group = 'Bufferline' },
		{ '<Space>c', group = 'Change' },
		{ '<Space>f', group = 'Find' },
		{ '<Space>g', group = 'Git' },
		{ '<Space>p', group = 'ChatGPT', icon = ' ' },
		{ '<Space>r', group = 'Resume' },
		{ '<Space>s', group = 'Scribe' },
		{ '<Space>t', group = 'Toggle' },
	})
	wk.setup(opts)
end

return spec
