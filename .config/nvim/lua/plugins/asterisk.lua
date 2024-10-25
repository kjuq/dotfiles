---@type LazySpec
local spec = { 'haya14busa/vim-asterisk' }

local map = require('utils.lazy').generate_map('', 'Asterisk: ')
local map_asterisk = function(key, plug)
	local rhs = function()
		if vim.v.hlsearch == 0 then
			require('utils.common').feed_plug(plug)
			local mode = vim.api.nvim_get_mode().mode
			if mode == 'r' or mode == 'rm' then
				return '<CR>'
			else
				return
			end
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
