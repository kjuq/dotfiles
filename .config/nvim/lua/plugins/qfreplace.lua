return {
    "thinca/vim-qfreplace",
    cmd = "Qfreplace",
    keys = {
        { "<leader>aq", mode = "n", function() vim.cmd("Qfreplace") end, { desc = "Qfreplace: Open" } },
    },
}
