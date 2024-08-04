local map = require('utils.lazy').generate_map('<leader>a', 'Replacer: ')

---@type LazySpec
local spec = { 'gabrielpoca/replacer.nvim' }

spec.keys = {
	map('q', 'n', function() require('replacer').run() end, 'Run'),
}

return spec
