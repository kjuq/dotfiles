---@type LazySpec
local spec = { 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' }
spec.branch = 'main'

local map = require('kjuq.utils.lazy').generate_map('', 'TS-textobjs: ')
spec.keys = {
	map('aa', { 'x', 'o' }, function()
		require('nvim-treesitter-textobjects.select').select_textobject('@parameter.outer', 'textobjects')
	end, '@parameter.outer'),
	map('ia', { 'x', 'o' }, function()
		require('nvim-treesitter-textobjects.select').select_textobject('@parameter.inner', 'textobjects')
	end, '@parameter.inner'),
	map('af', { 'x', 'o' }, function()
		require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects')
	end, '@function.outer'),
	map('if', { 'x', 'o' }, function()
		require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects')
	end, '@function.inner'),
	map('aC', { 'x', 'o' }, function()
		require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects')
	end, '@class.outer'),
	map('iC', { 'x', 'o' }, function()
		require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects')
	end, '@class.inner'),
	map('aT', { 'x', 'o' }, function()
		require('nvim-treesitter-textobjects.select').select_textobject('@conditional.outer', 'textobjects')
	end, '@conditional.outer'),
	map('iT', { 'x', 'o' }, function()
		require('nvim-treesitter-textobjects.select').select_textobject('@conditional.inner', 'textobjects')
	end, '@conditional.inner'),
	map('al', { 'x', 'o' }, function()
		require('nvim-treesitter-textobjects.select').select_textobject('@loop.outer', 'textobjects')
	end, '@loop.outer'),
	map('il', { 'x', 'o' }, function()
		require('nvim-treesitter-textobjects.select').select_textobject('@loop.inner', 'textobjects')
	end, '@loop.inner'),
	map('<M-t>', 'n', function()
		require('nvim-treesitter-textobjects.swap').swap_next('@parameter.inner')
	end, 'Swap forward'),
	map('<M-d>', 'n', function()
		require('nvim-treesitter-textobjects.swap').swap_previous('@parameter.inner')
	end, 'Swap backward'),
}

spec.opts = {
	select = {
		lookahead = true,
	},
	move = {
		set_jumps = true,
	},
}

return spec
