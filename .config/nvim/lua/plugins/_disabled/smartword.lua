---@type LazySpec
local spec = { 'kana/vim-smartword' }

spec.keys = {}

local map = require('kjuq.utils.lazy').generate_map('', 'Smartword: ')
spec.keys = {
	map('w', { 'n', 'x', 'o' }, function()
		require('kjuq.utils.common').feed_plug('smartword-w')
	end, 'w', { expr = true }),
	map('b', { 'n', 'x', 'o' }, function()
		require('kjuq.utils.common').feed_plug('smartword-b')
	end, 'b', { expr = true }),
	map('e', { 'n', 'x', 'o' }, function()
		require('kjuq.utils.common').feed_plug('smartword-e')
	end, 'e', { expr = true }),
	map('ge', { 'n', 'x', 'o' }, function()
		require('kjuq.utils.common').feed_plug('smartword-ge')
	end, 'ge', { expr = true }),
}

return spec
