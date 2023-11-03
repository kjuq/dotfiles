return {
    "ahmedkhalf/project.nvim",
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
    config = function()
        require("project_nvim").setup {}
    end,
}
