local map = require("utils.lazy").generate_map("", "Project: ")

local manual_mode = false

---@type LazySpec
local spec = { "ahmedkhalf/project.nvim" }
spec.name = "project_nvim"

spec.event = not manual_mode and { "BufNewFile", "BufReadPost" } or {}

spec.cmd = {
	"ProjectRoot",
	"AddProject",
}

spec.keys = {
	map("<leader>a.", "n", "<Cmd>ProjectRoot<CR>", "cd <project_root>"),
	map("<leader>fP", "n", function()
		local has_telescope, telescope = pcall(require, "telescope")
		if has_telescope then
			telescope.extensions.projects.projects({})
		else
			vim.notify("Telescope is not installed")
		end
	end, "Pick projects"),
}

spec.opts = {
	manual_mode = manual_mode,
	detection_methods = { "pattern" },
}

return spec
