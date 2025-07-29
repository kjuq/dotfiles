local map = require('kjuq.utils.lazy').generate_map('<Space>a', 'Himalaya: ')

---@type LazySpec
local spec = { 'https://github.com/pimalaya/himalaya-vim' }
spec.cmd = 'Himalaya'

spec.enabled = vim.fn.executable('himalaya') == 1

spec.event = 'CmdLineEnter'

spec.keys = {
	map('h', 'n', '<CMD>Himalaya<CR>', 'Open'),
}

return spec
