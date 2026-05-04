---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/gbprod/substitute.nvim' }

local map = require('kjuq.lazy').generate_map('', 'Substitute: ')
spec.keys = {
	map('S', 'n', function()
		require('substitute').operator()
	end, 'Start'),
	map('SS', 'n', function()
		require('substitute').line()
	end, 'Line'),
	map('S', 'x', function()
		require('substitute').visual()
	end, 'Visual'),
}

spec.opts = {
	highlight_substituted_text = {
		timer = require('kjuq.common_params').highlight_duration,
	},
}

return spec
