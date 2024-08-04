local map = require('utils.lazy').generate_map('<leader>a', 'Himalaya: ')

---@type LazySpec
local spec = { 'https://git.sr.ht/~soywod/himalaya-vim' }
spec.commit = '64fb17067cf5dbf5349726b9ed1b1b38065cdb82'
spec.cmd = 'Himalaya'

spec.keys = {
	map('h', 'n', '<CMD>Himalaya<CR>', 'Open'),
}

return spec
