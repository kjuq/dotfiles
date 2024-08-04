---@type LazySpec
local spec = { 'gbprod/substitute.nvim' }

local map = require('utils.lazy').generate_map('', 'Substitute: ')
spec.keys = {
	map('s', 'n', function() require('substitute').operator() end, 'Start'),
	map('ss', 'n', function() require('substitute').line() end, 'Line'),
	map('s', 'x', function() require('substitute').visual() end, 'Visual'),
}

spec.opts = {
	highlight_substituted_text = {
		timer = require('utils.common').highlight_duration,
	},
}

spec.config = function(_, opts)
	local has_yanky, yanky_int = pcall(require, 'yanky.integration')
	if has_yanky then opts.on_substitute = function() yanky_int.substitute() end end
	require('substitute').setup(opts)
end

return spec
