---@type LazySpec
local spec = { 'haya14busa/vim-asterisk' }

local map = require('utils.lazy').generate_map('', 'Asterisk: ')
spec.keys = {

	map('*', { 'n', 'x' }, function()
		if vim.v.hlsearch == 0 then
			return '<Plug>(asterisk-z*)<CR>'
		else
			return 'n'
		end
	end, 'z*', { expr = true }),

	map('g*', { 'n', 'x' }, function()
		if vim.v.hlsearch == 0 then
			return '<Plug>(asterisk-gz*)<CR>'
		else
			return 'n'
		end
	end, 'gz*', { expr = true }),

	map('#', { 'n', 'x' }, function()
		if vim.v.hlsearch == 0 then
			return '<Plug>(asterisk-z#)<CR>'
		else
			return 'n'
		end
	end, 'z#', { expr = true }),

	map('g#', { 'n', 'x' }, function()
		if vim.v.hlsearch == 0 then
			return '<Plug>(asterisk-gz#)<CR>'
		else
			return 'n'
		end
	end, 'gz#', { expr = true }),
}

return spec
