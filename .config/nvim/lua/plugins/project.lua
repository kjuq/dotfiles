return {
    "ahmedkhalf/project.nvim",
    name = "project_nvim",
    event = { "BufNewFile", "BufReadPost" },
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
            desc = "Telescope.extensions: [p]ick [p]rojects",
        },
    },
    opts = {
        detection_methods = { "pattern" },
    },
}
