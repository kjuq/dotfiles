local map = require('kjuq.utils.lazy').generate_map('', 'Todo: ')

---@type LazySpec
local spec = { 'folke/todo-comments.nvim' }
spec.event = 'VeryLazy'

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

spec.config = function(_, opts)
	require('todo-comments').setup(opts)

	-- Disable plugin/highlight-todo.lua
	vim.api.nvim_del_augroup_by_name('kjuq_highlight_todo')
	for _, id in ipairs(Kjuq_hl_todo_ids) do
		vim.fn.matchdelete(id)
	end
end

spec.specs = { 'nvim-lua/plenary.nvim' }

return spec
