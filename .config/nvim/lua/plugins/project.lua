---@type LazySpec
local spec = { "ahmedkhalf/project.nvim" }
spec.name = "project_nvim"
spec.event = { "BufNewFile", "BufReadPost" } -- necessary

spec.keys = {
	{
		"<leader>fP",
		mode = { "n" },
		function()
			local has_telescope, telescope = pcall(require, "telescope")
			if has_telescope then
				telescope.extensions.projects.projects({})
			else
				print("Telescope is not installed")
			end
		end,
		desc = "Project: Pick projects",
	},
}

spec.opts = {
	detection_methods = { "pattern" },
}

return spec
