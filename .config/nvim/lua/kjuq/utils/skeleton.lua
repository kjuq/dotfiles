local success, conf_dir = pcall(os.getenv, 'XDG_CONFIG_HOME')
if not success then
	conf_dir = os.getenv('HOME') .. '/.config'
end

local common = require('kjuq.utils.common')

local M = {}

M.skel_path = conf_dir .. '/nvim/skeleton/'

M.paste_skeleton = function(filename)
	if (not common.is_current_file_exists()) and common.is_empty_buffer() then
		vim.cmd.read({
			args = { require('kjuq.utils.skeleton').skel_path .. filename },
			mods = { silent = true },
		})
		vim.cmd.delete({
			range = { 1 },
			mods = { silent = true },
		})
	end
end

return M
