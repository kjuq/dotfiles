local map = require('kjuq.utils.lazy').generate_map('', 'Action-preview: ')

---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/aznhe21/actions-preview.nvim' }

spec.keys = {
	map('', { 'n', 'x' }, function()
		require('actions-preview').code_actions()
	end, 'Open'),
}

spec.specs = {
	'MunifTanjim/nui.nvim',
}

return spec
