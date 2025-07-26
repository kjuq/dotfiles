local map = require('kjuq.utils.lazy').generate_map('', 'Yanky: ')

---@type LazySpec
local spec = { 'https://github.com/gbprod/yanky.nvim' }

spec.event = { 'TextYankPost' }

spec.keys = {
	map('p', { 'n', 'x' }, '<Plug>(YankyPutAfter)', 'Put after'),
	map('P', { 'n', 'x' }, '<Plug>(YankyPutBefore)', 'Put before'),
	map('gp', { 'n', 'x' }, '<Plug>(YankyGPutAfter)', 'GPut after'),
	map('gP', { 'n', 'x' }, '<Plug>(YankyGPutBefore)', 'GPut before'),

	map('-', 'n', function()
		if require('yanky').can_cycle() then
			return '<Plug>(YankyPreviousEntry)'
		else
			return '-'
		end
	end, 'Previous entry', { expr = true }),
	map('+', 'n', function()
		if require('yanky').can_cycle() then
			return '<Plug>(YankyNextEntry)'
		else
			return '+'
		end
	end, 'Next entry', { expr = true }),

	map('<Space>fy', 'n', '<CMD>YankyRingHistory<CR>', 'History'),
}

spec.config = function()
	local utils = require('yanky.utils')
	local opts = {
		ring = {
			history_length = 20,
			cancel_event = 'move',
			ignore_registers = { '_', '+', '*' },
			update_register_on_cycle = true,
		},
		system_clipboard = {
			sync_with_ring = false,
		},
		highlight = {
			on_put = true,
			on_yank = false,
			timer = require('kjuq.utils.common').highlight_duration,
		},
		picker = {
			select = {
				action = require('yanky.picker').actions.set_register(utils.get_default_register()),
			},
		},
	}
	require('yanky').setup(opts)
end

return spec
