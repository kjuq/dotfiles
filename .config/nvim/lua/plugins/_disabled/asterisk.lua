---@type LazySpec
local spec = { 'haya14busa/vim-asterisk' }

local map = require('utils.lazy').generate_map('', 'Asterisk: ')
local map_asterisk = function(key, plug)
	local rhs = function()
		if vim.v.hlsearch == 0 then
			return '<Plug>(' .. plug .. ')<CR>'
		else
			return 'n'
		end
	end
	return map(key, { 'n', 'x' }, rhs, plug, { expr = true })
end

spec.keys = {
	map_asterisk('*', 'asterisk-z*'),
	map_asterisk('g*', 'asterisk-gz*'),
	map_asterisk('#', 'asterisk-z#'),
	map_asterisk('g#', 'asterisk-gz#'),
}

return spec
