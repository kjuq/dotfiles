return {
    "ahmedkhalf/project.nvim",
    event = { "VeryLazy" },
    keys = {
        {
            "<leader>pp",
            mode = { "n" },
            function () require('telescope').extensions.projects.projects{} end,
            desc = "Telescope.extensions: [p]ick [p]rojects",
        },
    },
    config = function()
        require("project_nvim").setup {}
    end,
}


