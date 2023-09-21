return {
    "ahmedkhalf/project.nvim",
    event = { "BufWinEnter" },
    keys = {
        { "<leader>fp", mode = { "n" }, function () require('telescope').extensions.projects.projects{} end },
    },
    config = function()
        require("project_nvim").setup {}
    end,
}


