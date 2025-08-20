---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/willothy/flatten.nvim' }

spec.lazy = os.getenv('NVIM') == nil

spec.opts = {
	window = {
		open = 'alternate', -- for toggleterm integration
	},
}

return spec
