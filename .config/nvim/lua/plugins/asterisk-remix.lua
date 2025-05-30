---@type LazySpec
local spec = { 'https://github.com/kjuq/asterisk-remix' }

-- spec.dev = true

local map = require('kjuq.utils.lazy').generate_map('', 'Asterisk: ')
spec.keys = {
	-- stylua: ignore start
	map('*', 'n', function() require('asterisk-remix').normal_search('*') end, '*'),
	map('#', 'n', function() require('asterisk-remix').normal_search('#') end, '#'),
	map('g*', 'n', function() require('asterisk-remix').normal_search('g*') end, 'g*'),
	map('g#', 'n', function() require('asterisk-remix').normal_search('g#') end, 'g#'),
	map('*', 'x', function() return require('asterisk-remix').visual_search('*') end, '*', { expr = true }),
	map('#', 'x', function() return require('asterisk-remix').visual_search('#') end, '#', { expr = true }),
	map('<Space>*', 'n', function() return require('asterisk-remix').operator_search('*') end, 'Ope *', { expr = true }),
	map('<Space>#', 'n', function() return require('asterisk-remix').operator_search('#') end, 'Ope #', { expr = true }),
	-- stylua: ignore end
}

return spec
