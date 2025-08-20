---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/akinsho/git-conflict.nvim' }

spec.version = '*'

spec.event = 'VeryLazy'

local map = require('kjuq.utils.lazy').generate_map('', 'Git-conflict: ')
spec.keys = {
	map('<Space>gcl', 'n', '<Cmd>GitConflictListQf<CR>', 'List QuickFix'),
	map('<Space>gc]', 'n', '<Cmd>GitConflictChooseTheirs<CR>', 'Choose theirs'),
	map('<Space>gc[', 'n', '<Cmd>GitConflictChooseOurs<CR>', 'Choose ours'),
	map('<Space>gc=', 'n', '<Cmd>GitConflictChooseBoth<CR>', 'Choose both'),
	map('<Space>gc-', 'n', '<Cmd>GitConflictChooseNone<CR>', 'Choose none'),
	map('<Space>gc_', 'n', '<Cmd>GitConflictChooseBase<CR>', 'Choose base'),
	map(']c', 'n', '<Cmd>GitConflictNextConflict<CR>', 'Next conflict'),
	map('[c', 'n', '<Cmd>GitConflictPrevConflict<CR>', 'Previous conflict'),
}

spec.opts = {}

spec.config = function(_, opts)
	require('git-conflict').setup(opts)

	-- for lazy load
	vim.cmd.GitConflictRefresh()
end

return spec
