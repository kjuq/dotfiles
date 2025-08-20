local map = require('kjuq.utils.lazy').generate_map('', 'Op-camelize: ')

---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/tyru/operator-camelize.vim' }

spec.keys = {
	map('<Space>cc', { 'n', 'x' }, function()
		require('kjuq.utils.common').feed_plug('operator-camelize')
	end, 'Camelize'),
	map('<Space>cC', { 'n', 'x' }, function()
		require('kjuq.utils.common').feed_plug('operator-decamelize')
	end, 'Decamelize'),
}

spec.dependencies = {
	'kana/vim-operator-user',
}

return spec
