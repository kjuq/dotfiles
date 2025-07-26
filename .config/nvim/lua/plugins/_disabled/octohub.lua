---@type LazySpec
local spec = { 'https://github.com/2KAbhishek/octohub.nvim' }

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

spec.opts = {
	projects_dir = os.getenv('GHQ_ROOT') and os.getenv('GHQ_ROOT') .. 'github.com' or '~/ghq/github.com/',
	sort_repos_by = 'updated', -- Sort repositories by various parameters
	add_default_keybindings = false, -- Add default keybindings for the plugin
}

spec.specs = {
	'2kabhishek/utils.nvim',
	-- 'nvim-telescope/telescope.nvim',
}

return spec
