local map = require('utils.lazy').generate_map('<Space>a', 'QuickHL: ')

---@type LazySpec
local spec = { 't9md/vim-quickhl' }

spec.keys = {
	map('m', { 'n', 'x' }, function()
		require('utils.common').feed_plug('quickhl-manual-this')
	end, 'Mark'),
	map('M', { 'n', 'x' }, function()
		require('utils.common').feed_plug('quickhl-manual-reset')
	end, 'Reset'),
}

return spec
