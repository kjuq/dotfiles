local map = require('kjuq.utils.lazy').generate_map('', 'Dial: ')

---@type LazySpec
local spec = { 'monaqa/dial.nvim' }

spec.keys = {
	map('<C-a>', { 'n', 'x' }, '<Plug>(dial-increment)', 'Increment'),
	map('<C-x>', { 'n', 'x' }, '<Plug>(dial-decrement)', 'Decrement'),
	map('g<C-a>', 'x', 'g<Plug>(dial-increment)', 'G Increment', { remap = true }),
	map('g<C-x>', 'x', 'g<Plug>(dial-decrement)', 'G Decrement', { remap = true }),
}

return spec
