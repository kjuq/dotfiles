---@type LazySpec
local spec = { 't9md/vim-quickhl' }

local map = require('utils.lazy').generate_map('<Space>', 'QuickHL: ')
spec.keys = {
	map('*', { 'n', 'x' }, function()
		require('utils.common').feed_plug('quickhl-manual-this')
	end, 'Mark'),
	map('#', { 'n', 'x' }, function()
		require('utils.common').feed_plug('quickhl-manual-reset')
	end, 'Reset'),
}

return spec
