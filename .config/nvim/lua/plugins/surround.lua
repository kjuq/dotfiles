---@type LazySpec
local spec = { 'https://github.com/kylechui/nvim-surround' }
spec.version = '*' -- Use for stability; omit to use `main` branch for the latest features

spec.keys = {
	{ '<C-g>s', mode = { 'i' } },
	{ '<C-g>S', mode = { 'i' } },
	{ 'ys', mode = { 'n' } },
	{ 'yS', mode = { 'n' } },
	{ 'S', mode = { 'x' } },
	{ 'gS', mode = { 'x' } },
	{ 'ds', mode = { 'n' } },
	{ 'cs', mode = { 'n' } },
	{ 'cS', mode = { 'n' } },
}

spec.opts = {
	surrounds = {
		['c'] = { -- Markdown fenced code blocks
			add = function()
				return { '```', '```' }
			end,
		},
	},
}

spec.dependencies = {
	'nvim-treesitter/nvim-treesitter',
}

return spec
