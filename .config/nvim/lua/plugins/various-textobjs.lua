---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/chrisgrieser/nvim-various-textobjs' }

local map = require('kjuq.lazy').generate_map('', 'Various-textobjs: ')
spec.keys = {
	map('ii', { 'o', 'x' }, function()
		if vim.fn.indent('.') == 0 then
			require('various-textobjs').entireBuffer()
		else
			require('various-textobjs').indentation('inner', 'inner')
		end
	end, 'Indentation (inner without blanks)'),
	map('ai', { 'o', 'x' }, function()
		if vim.fn.indent('.') == 0 then
			require('various-textobjs').entireBuffer()
		else
			require('various-textobjs').indentation('outer', 'outer')
		end
	end, 'Indentation (outer without blanks)'),

	map('ir', { 'o', 'x' }, function()
		require('various-textobjs').subword('inner', 'inner')
	end, 'Subword (inner)'),
	map('ar', { 'o', 'x' }, function()
		require('various-textobjs').subword('outer', 'outer')
	end, 'Subword (outer)'),

	map('iq', { 'o', 'x' }, function()
		require('various-textobjs').anyQuote('inner', 'inner')
	end, 'Any Quote (inner)'),
	map('aq', { 'o', 'x' }, function()
		require('various-textobjs').anyQuote('outer', 'outer')
	end, 'Any Quote (outer)'),

	map('gG', { 'o', 'x' }, function()
		require('various-textobjs').entireBuffer()
	end, 'Entire Buffer'),
}

spec.opts = {
	lookForwarding = {
		big = 15,
		small = 5,
	},
	keymaps = {
		useDefaults = false,
	},
	notify = {
		whenObjectNotFound = false,
	},
	textobjs = {
		indent = {
			blanksAreDelimiter = true,
		},
	},
}

return spec
