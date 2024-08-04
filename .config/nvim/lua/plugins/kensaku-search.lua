local map = require('utils.lazy').generate_map('', 'Kensaku-search: ')

---@type LazySpec
local spec = { 'lambdalisue/kensaku-search.vim' }

spec.event = 'User UserDenopsActivated'

spec.keys = {
	map('<C-s>', 'c', function() return '<Plug>(kensaku-search-replace)<CR>' end, 'Confirm', { expr = true }),
	'/',
}

spec.dependencies = {
	'vim-denops/denops.vim',
	'lambdalisue/kensaku.vim',
}

return spec
