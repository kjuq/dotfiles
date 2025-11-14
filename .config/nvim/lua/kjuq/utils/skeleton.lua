local M = {}

local helper = require('kjuq.utils.helper')
M.paste_skeleton = function(filename)
	if (not helper.is_current_file_exists()) and helper.is_empty_buffer() then
		vim.cmd.read({
			args = { vim.fn.stdpath('config') .. '/nvim/skeleton/' .. filename },
			mods = { silent = true },
		})
		vim.cmd.delete({
			range = { 1 },
			mods = { silent = true },
		})
	end
end

return M
