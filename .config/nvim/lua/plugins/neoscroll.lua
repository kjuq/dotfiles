local map = require('kjuq.utils.lazy').generate_map('', 'Neoscroll: ')

local duration = 50

---@type LazySpec
local spec = { 'https://github.com/karb94/neoscroll.nvim' }

spec.keys = {

	map('<C-u>', { 'n', 'x' }, function()
		require('neoscroll').scroll(-vim.wo.scroll, { move_cursor = true, duration = duration })
	end, 'Half up'),

	map('<C-d>', { 'n', 'x' }, function()
		require('neoscroll').scroll(vim.wo.scroll, { move_cursor = true, duration = duration })
	end, 'Half down'),

	map('<C-b>', { 'n', 'x' }, function()
		require('neoscroll').scroll(-vim.api.nvim_win_get_height(0), { move_cursor = true, duration = duration * 2 })
	end, 'Up'),

	map('<C-f>', { 'n', 'x' }, function()
		require('neoscroll').scroll(vim.api.nvim_win_get_height(0), { move_cursor = true, duration = duration * 2 })
	end, 'Down'),

	map('zt', { 'n', 'x' }, function()
		require('neoscroll').zt(duration * 0.75)
	end, 'Top this line'),
	map('zz', { 'n', 'x' }, function()
		require('neoscroll').zz(duration * 0.75)
	end, 'Center this line'),
	map('zb', { 'n', 'x' }, function()
		require('neoscroll').zb(duration * 0.75)
	end, 'Bottom this line'),
}

spec.opts = {
	mappings = {},
	hide_cursor = false,
}

return spec
