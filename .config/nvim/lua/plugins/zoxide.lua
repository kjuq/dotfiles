return {
    "nanotee/zoxide.vim",
    keys = {
        { "z", mode = "c" },
        { "Z", mode = "c" },
    },
    config = function ()
        vim.cmd.cnoreabbrev("z", "Z");
    end
}



