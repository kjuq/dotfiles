---@type LazySpec
local spec = { 'https://github.com/t9md/vim-quickhl' }

local map = require('kjuq.utils.lazy').generate_map('<Space>', 'QuickHL: ')
spec.keys = {
	map('*', { 'n', 'x' }, function()
		require('kjuq.utils.common').feed_plug('quickhl-manual-this')
	end, 'Mark'),
	map('#', { 'n', 'x' }, function()
		require('kjuq.utils.common').feed_plug('quickhl-manual-reset')
	end, 'Reset'),
}

return spec
