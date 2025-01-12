local map = require('kjuq.utils.lazy').generate_map('', 'Kensaku-search: ')

---@type LazySpec
local spec = { 'lambdalisue/kensaku-search.vim' }

spec.event = 'User DenopsReady'

spec.keys = {
	map('<C-s>', 'c', function()
		return '<Plug>(kensaku-search-replace)<CR>'
	end, 'Confirm', { expr = true }),
	'/',
}

spec.dependencies = {
	'vim-denops/denops.vim',
	'lambdalisue/kensaku.vim',
}

return spec
