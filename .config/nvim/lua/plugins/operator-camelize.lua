local map = require('utils.lazy').generate_map('', 'Op-camelize: ')

---@type LazySpec
local spec = { 'tyru/operator-camelize.vim' }

spec.keys = {
	map('<Space>cc', { 'n', 'x' }, function()
		require('utils.common').feed_plug('operator-camelize')
	end, 'Camelize'),
	map('<Space>cC', { 'n', 'x' }, function()
		require('utils.common').feed_plug('operator-decamelize')
	end, 'Decamelize'),
}

spec.dependencies = {
	'kana/vim-operator-user',
}

return spec
