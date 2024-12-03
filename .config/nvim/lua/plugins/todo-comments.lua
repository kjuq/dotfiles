local map = require('utils.lazy').generate_map('', 'Todo: ')

---@type LazySpec
local spec = { 'folke/todo-comments.nvim' }
spec.event = 'VeryLazy'

spec.keys = {
	map(']t', 'n', function()
		require('todo-comments').jump_next()
	end, 'Next todo comment'),
	map('[t', 'n', function()
		require('todo-comments').jump_prev()
	end, 'Previous todo comment'),
	map('<Space>aD', 'n', function()
		require('todo-comments').jump_prev()
	end, 'Previous todo comment'),
}

spec.opts = {
	signs = false,
	highlight = {
		multiline = false,
		pattern = [[.*<(KEYWORDS):\s*]],
		before = 'fg',
		keyword = 'wide',
	},
	search = {
		pattern = [[\b(KEYWORDS)\b]],
	},
}

spec.specs = { 'nvim-lua/plenary.nvim' }

return spec
