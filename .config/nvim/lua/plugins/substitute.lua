---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/gbprod/substitute.nvim' }

local map = require('kjuq.lazy').generate_map('', 'Substitute: ')
spec.keys = {
	map('s', 'n', function()
		require('substitute').operator()
	end, 'Start'),
	map('ss', 'n', function()
		require('substitute').line()
	end, 'Line'),
	map('s', 'x', function()
		require('substitute').visual()
	end, 'Visual'),
}

spec.opts = {
	highlight_substituted_text = {
		timer = require('kjuq.common_params').highlight_duration,
	},
}

spec.config = function(_, opts)
	local has_yanky, yanky_int = pcall(require, 'yanky.integration')
	if has_yanky then
		-- It is necessary to setup in `config` to integrate with yanky
		opts.on_substitute = yanky_int.substitute()
	end
	require('substitute').setup(opts)
end

return spec
