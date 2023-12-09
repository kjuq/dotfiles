return {
    "ahmedkhalf/project.nvim",
    name = "project_nvim",
    event = { "BufNewFile", "BufReadPost" }, -- necessary
    keys = {
        {
            "<leader>pp",
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
    },
    opts = {
        detection_methods = { "pattern" },
    },
}
