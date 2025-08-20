---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/haya14busa/vim-edgemotion' }

local map = require('kjuq.utils.lazy').generate_map('', 'Edgemotion: ')
spec.keys = {
	map('<C-n>', { 'n', 'x' }, '<Plug>(edgemotion-j)', 'Down'),
	map('<C-p>', { 'n', 'x' }, '<Plug>(edgemotion-k)', 'Up'),
}

return spec
