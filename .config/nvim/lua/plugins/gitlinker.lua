---@type LazySpec
local spec = { 'linrongbin16/gitlinker.nvim' }

spec.cmd = 'GitLink'

local map = require('kjuq.utils.lazy').generate_map('', 'Gitlinker: ')
spec.keys = {
	map('<Space>gy', { 'n', 'x' }, '<Cmd>GitLink<CR>', 'Yank git link'),
	map('<Space>gY', { 'n', 'x' }, '<Cmd>GitLink!<CR>', 'Open git link'),
}

spec.opts = {}

return spec
