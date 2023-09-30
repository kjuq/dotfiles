return {
    "ahmedkhalf/project.nvim",
    event = { "BufWinEnter" },
    keys = {
        {
            "<leader>fp",
            mode = { "n" },
            function () require('telescope').extensions.projects.projects{} end,
            desc = "Telescope.extensions: projects",
        },
    },
    config = function()
        require("project_nvim").setup {}
    end,
}


