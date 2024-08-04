---@type LazySpec
local spec = { 'nvim-neorg/neorg' }
spec.build = ':Neorg sync-parsers'
spec.ft = 'norg'
spec.cmd = 'Neorg'

spec.config = function()
	require('neorg').setup({
		load = {
			['core.defaults'] = {}, -- Loads default behaviour
			['core.concealer'] = {}, -- Adds pretty icons to your documents
			['core.dirman'] = { -- Manages Neorg workspaces
				config = {
					workspaces = {
						notes = '~/documents/__neorg',
					},
				},
			},
			['core.keybinds'] = {
				config = {
					hook = function(keybinds)
						local leader = keybinds.leader
						keybinds.remap_key('norg', 'n', '<C-Space>', leader .. 'tt')
						keybinds.remap_key('norg', 'n', leader .. 'id', leader .. 'dt')
					end,
				},
			},
		},
	})
end

spec.specs = { 'nvim-lua/plenary.nvim' }

return spec
