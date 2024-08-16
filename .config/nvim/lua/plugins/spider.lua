---@type LazySpec
local spec = { 'chrisgrieser/nvim-spider' }

local map = require('utils.lazy').generate_map('', 'Spider: ')
spec.keys = {
	map('w', { 'n', 'x', 'o' }, function()
		require('jolyne').motion(function()
			require('spider').motion('w')
		end)
	end, 'w'),
	map('b', { 'n', 'x', 'o' }, function()
		require('jolyne').motion(function()
			require('spider').motion('b')
		end)
	end, 'b'),
	map('e', { 'n', 'x', 'o' }, function()
		require('jolyne').motion(function()
			require('spider').motion('e')
		end)
	end, 'e'),
	map('ge', { 'n', 'x', 'o' }, function()
		require('jolyne').motion(function()
			require('spider').motion('ge')
		end)
	end, 'ge'),
	-- map('w', { 'n', 'x', 'o' }, function() require('spider').motion('w') end, 'w'),
	-- map('b', { 'n', 'x', 'o' }, function() require('spider').motion('b') end, 'b'),
	-- map('e', { 'n', 'x', 'o' }, function() require('spider').motion('e') end, 'e'),
	-- map('ge', { 'n', 'x', 'o' }, function() require('spider').motion('ge') end, 'ge'),
}

spec.opts = {}

return spec
