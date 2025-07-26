local map = require('kjuq.utils.lazy').generate_map('<Space>a', 'Replacer: ')

---@type LazySpec
local spec = { 'https://github.com/gabrielpoca/replacer.nvim' }

spec.keys = {
	map('q', 'n', function()
		require('replacer').run()
	end, 'Run'),
}

return spec
