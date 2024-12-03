local map = require('utils.lazy').generate_map('<Space>a', 'Which-key: ')

local active = false

local enable = function()
	vim.o.timeout = true
	vim.o.timeoutlen = 500
	active = true
end

local disable = function()
	vim.o.timeout = false
	active = false
end

local toggle = function()
	if active then
		vim.notify('Which-key is inactive')
		disable()
	else
		vim.notify('Which-key is active')
		enable()
	end
end

---@type LazySpec
local spec = { 'folke/which-key.nvim' }
spec.event = 'VeryLazy'

spec.keys = {
	map('w', 'n', toggle, 'Toggle'),
	map('W', 'n', function()
		vim.cmd('WhichKey')
	end, 'Show all keymaps'),
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
		{ 'ga', group = 'Additional actions' },
		{ 'go', group = 'Edit specific file' },
		{ '<Space>a', group = 'Additional' },
		{ '<Space>b', group = 'Bufferline' },
		{ '<Space>c', group = 'ChatGPT', icon = ' ' },
		{ '<Space>d', group = 'Doc string' },
		{ '<Space>D', group = 'Debug' },
		{ '<Space>f', group = 'Find' },
		{ '<Space>g', group = 'Git' },
		{ '<Space>r', group = 'Resume' },
		{ '<Space>s', group = 'Substitute' },
		{ '<Space>t', group = 'Trouble' },
	})
	wk.setup(opts)
end

return spec
