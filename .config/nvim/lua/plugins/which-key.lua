local map = require('utils.lazy').generate_map('<leader>a', 'Which-key: ')

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

spec.enabled = os.getenv('SSH_TTY') == nil -- which-key breaks osc52

spec.keys = {
	map('w', 'n', toggle, 'Toggle'),
	map('W', 'n', function() vim.cmd('WhichKey') end, 'Show all keymaps'),
}

spec.opts = {
	preset = 'modern',
	win = {
		no_overlap = false,
		border = 'single',
	},
	keys = { -- FIXME: this option doesn't affect
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
		{ '<leader>a', group = 'Additional' },
		{ '<leader>c', group = 'ChatGPT', icon = ' ' },
		{ '<leader>d', group = 'Doc string' },
		{ '<leader>D', group = 'Debug' },
		{ '<leader>f', group = 'Find' },
		{ '<leader>g', group = 'Git' },
		{ '<leader>r', group = 'Resume' },
		{ '<leader>s', group = 'Substitute' },
		{ '<leader>t', group = 'Trouble' },
	})
	wk.setup(opts)
end

return spec
