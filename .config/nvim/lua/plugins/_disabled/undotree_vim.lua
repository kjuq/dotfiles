local map = require('kjuq.utils.lazy').generate_map('', 'Undotree: ')

---@type LazySpec
local spec = { 'https://github.com/mbbill/undotree' }

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
