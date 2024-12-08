---@type LazySpec
local spec = { 'https://github.com/stevearc/overseer.nvim' }

spec.cmd = {
	'OverseerOpen',
	'OverseerClose',
	'OverseerToggle',
	'OverseerSaveBundle',
	'OverseerLoadBundle',
	'OverseerDeleteBundle',
	'OverseerRunCmd',
	'OverseerRun',
	'OverseerInfo',
	'OverseerBuild',
	'OverseerQuickAction',
	'OverseerTaskAction',
	'OverseerClearCache',
}

local map = require('utils.lazy').generate_map('', 'Overseer: ')
spec.keys = {
	map('<Space>ar', 'n', '<Cmd>OverseerRun<CR>', 'Run'),
}

spec.opts = {
	templates = {
		-- 'builtin',
		'kjuq', -- $XDG_CONFIG_HOME/nvim/lua/overseer/template/kjuq
	},
}

return spec
