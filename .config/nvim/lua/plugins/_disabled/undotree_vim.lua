local map = require('utils.lazy').generate_map('', 'Undotree: ')

---@type LazySpec
local spec = { 'mbbill/undotree' }

spec.cmd = {
	'UndotreeToggle',
	'UndotreeHide',
	'UndotreeShow',
	'UndotreeFocus',
	'UndotreePersistUndo',
}

spec.keys = {
	map('<Space>au', 'n', '<Cmd>UndotreeToggle<CR>', 'Toggle'),
}

return spec
