---@type LazySpec
local spec = { '2KAbhishek/octohub.nvim' }

spec.cmd = {
	'OctoRepos',
	'OctoRepo',
	'OctoStats',
	'OctoActivityStats',
	'OctoContributionStats',
	'OctoRepoStats',
	'OctoProfile',
	'OctoRepoWeb',
}

local map = require('utils.lazy').generate_map('', '')
spec.keys = {}

spec.opts = {
	projects_dir = os.getenv('GHQ_ROOT') and os.getenv('GHQ_ROOT') .. 'github.com' or '~/ghq/github.com/',
	sort_repos_by = 'updated', -- Sort repositories by various parameters
	add_default_keybindings = false, -- Add default keybindings for the plugin
}

spec.specs = {
	'2kabhishek/utils.nvim',
	'nvim-telescope/telescope.nvim',
}

return spec
