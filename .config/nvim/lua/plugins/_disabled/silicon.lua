local map = require('kjuq.utils.lazy').generate_map('<Space>a', 'Silicon: ')

---@type LazySpec
local spec = { 'https://github.com/segeljakt/vim-silicon' }
spec.cmd = 'Silicon'

spec.config = function()
	local store_dir = os.getenv('HOME') .. '/Documents/silicon'

	if vim.fn.isdirectory(store_dir) then
		vim.fn.mkdir(store_dir)
	end

	local datetime = os.date('%Y-%m-%d_%H-%M-%S')

	local v_true = 1
	local v_false = 0

	vim.g.silicon = {
		['theme'] = 'Dracula',
		['font'] = 'Hack',
		['background'] = '#AAAAFF',
		['shadow-color'] = '#555555',
		['line-pad'] = 2,
		['pad-horiz'] = 80,
		['pad-vert'] = 100,
		['shadow-blur-radius'] = 0,
		['shadow-offset-x'] = 0,
		['shadow-offset-y'] = 0,
		['line-number'] = v_false,
		['round-corner'] = v_true,
		['window-controls'] = v_true,
		['output'] = store_dir .. '/silicon-' .. datetime .. '.png',
	}
end

return spec
