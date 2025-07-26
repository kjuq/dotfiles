local map = require('kjuq.utils.lazy').generate_map('', 'Todo: ')

---@type LazySpec
local spec = { 'https://github.com/folke/todo-comments.nvim' }
spec.event = 'VeryLazy'

spec.init = function()
	Kjuq_plugin_disabled = { highlight_todo = true }
end

spec.keys = {
	map(']t', 'n', function() -- set `:tnext` by `_defaults.lua`
		require('todo-comments').jump_next()
	end, 'Next todo comment'),
	map('[t', 'n', function() -- set `:tprevious` by `_defaults.lua`
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
