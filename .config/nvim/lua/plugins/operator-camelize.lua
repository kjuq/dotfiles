local map = require('utils.lazy').generate_map('', 'Op-camelize: ')

---@type LazySpec
local spec = { 'tyru/operator-camelize.vim' }

spec.keys = {
	map('gC', { 'n', 'x' }, function()
		require('utils.common').feed_plug('operator-camelize')
	end, 'Camelize'),
	map('gB', { 'n', 'x' }, function()
		require('utils.common').feed_plug('operator-decamelize')
	end, 'Decamelize'),
}

spec.dependencies = {
	'kana/vim-operator-user',
}

return spec
