return {
    "famiu/bufdelete.nvim",
    cmd = {
        "Bdelete",
        "Bwipeout",
    },
    keys = {
        { "<leader>x", mode = { "n" }, function () require('bufdelete').bufdelete(0, false) end },
        { "<leader>X", mode = { "n" }, function () require('bufdelete').bufdelete(0, true) end },
    },
}

