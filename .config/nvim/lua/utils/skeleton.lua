local success, conf_dir = pcall(os.getenv, "XDG_CONFIG_HOME")
if not success then
	conf_dir = os.getenv("HOME") .. "/.config"
end

local common = require("utils.common")

local M = {}

M.skel_path = conf_dir .. "/nvim/ftplugin/skeleton/"
M.paste_skeleton = function(filename)
	-- if vim.fn.filereadable(vim.fn.bufname()) == 0 and vim.fn.line("$") == 1 and vim.fn.getline(1) == "" then
	if (not common.is_current_file_exists()) and common.is_empty_buffer() then
		vim.cmd.read({
			args = { require("utils.skeleton").skel_path .. filename },
			mods = { silent = true }
		})
		vim.cmd.delete({
			range = { 1 },
			mods = { silent = true }
		})
	end
end

return M
