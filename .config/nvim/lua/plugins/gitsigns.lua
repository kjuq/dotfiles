---@type LazySpec
local spec = { 'lewis6991/gitsigns.nvim' }
spec.event = 'VeryLazy'

local map = require('utils.lazy').generate_map('', 'Gitsigns: ')
spec.keys = {
	-- Navigation
	map(']g', 'n', function()
		if vim.wo.diff then return ']g' end
		vim.schedule(function() require('gitsigns').next_hunk() end)
		return '<Ignore>'
	end, 'Go to next hunk', { expr = true }),

	map('[g', 'n', function()
		if vim.wo.diff then return '[g' end
		vim.schedule(function() require('gitsigns').prev_hunk() end)
		return '<Ignore>'
	end, 'Go to next hunk', { expr = true }),

	-- Actions
	map('<leader>gh', 'n', function() require('gitsigns').stage_hunk() end, 'Stage hunk'),
	map('<leader>gr', 'n', function() require('gitsigns').reset_hunk() end, 'Reset hunk'),
	map('<leader>gs', 'n', function() require('gitsigns').stage_buffer() end, 'Stage buffer'),
	map('<leader>gu', 'n', function() require('gitsigns').undo_stage_hunk() end, 'Undo stage hunk'),
	map('<leader>gR', 'n', function() require('gitsigns').reset_buffer() end, 'Reset buffer'),
	map('<leader>gp', 'n', function() require('gitsigns').preview_hunk() end, 'Preview hunk'),
	map('<leader>gT', 'n', function() require('gitsigns').toggle_current_line_blame() end, 'Toggle current line blame'),
	map('<leader>gd', 'n', function() require('gitsigns').diffthis() end, 'Diff this'),
	map('<leader>gt', 'n', function() require('gitsigns').toggle_deleted() end, 'Toggle deleted'),
	map(
		'<leader>gh',
		'v',
		function() require('gitsigns').stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
		'Stage hunk'
	),
	map(
		'<leader>gr',
		'v',
		function() require('gitsigns').reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
		'Reset hunk'
	),
	map('<leader>gb', 'n', function() require('gitsigns').blame_line({ full = true }) end, 'Blame line'),
	map('<leader>gD', 'n', function() require('gitsigns').diffthis('~') end, 'Diff this "~" <- ?'),

	-- Text object
	map('<leader>gS', { 'o', 'x' }, ':<C-U>Gitsigns select_hunk<CR>', 'Select hunk'),
}

spec.opts = {
	signcolumn = false,
	numhl = true,
}

return spec
