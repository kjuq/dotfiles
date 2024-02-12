---@type LazySpec
local spec = { "ahmedkhalf/project.nvim" }
spec.name = "project_nvim"
spec.event = { "BufNewFile", "BufReadPost" } -- necessary

spec.keys = {
	{
		"<leader>fp",
		mode = { "n" },
		function()
			local has_telescope, _ = pcall(require, "telescope")
			if has_telescope then
				require('telescope').extensions.projects.projects {}
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
