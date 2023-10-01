return {
    "ahmedkhalf/project.nvim",
    event = { "VeryLazy" },
    keys = {
        {
            "<leader>lp",
            mode = { "n" },
            function () require('telescope').extensions.projects.projects{} end,
            desc = "Telescope.extensions: [l]ist [p]rojects",
        },
    },
    config = function()
        require("project_nvim").setup {}
    end,
}


