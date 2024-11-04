-- vim.g.clipboard = {
-- 	name = 'OSC 52',
-- 	copy = {
-- 		['+'] = require('vim.ui.clipboard.osc52').copy('+'),
-- 		['*'] = require('vim.ui.clipboard.osc52').copy('*'),
-- 	},
-- 	paste = {
-- 		['+'] = require('vim.ui.clipboard.osc52').paste('+'),
-- 		['*'] = require('vim.ui.clipboard.osc52').paste('*'),
-- 	},
-- }

local paste = function()
	return {
		vim.fn.split(vim.fn.getreg(''), '\n'),
		vim.fn.getregtype(''),
	}
end

vim.g.clipboard = {
	name = 'OSC 52',
	copy = {
		['+'] = require('vim.ui.clipboard.osc52').copy('+'),
		['*'] = require('vim.ui.clipboard.osc52').copy('*'),
	},
	paste = {
		['+'] = paste,
		['*'] = paste,
	},
}
