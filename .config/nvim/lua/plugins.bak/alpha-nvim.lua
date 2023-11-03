return {
    'goolord/alpha-nvim',
    event = { "BufWinEnter" },
    config = function ()
        require("alpha").setup(require("alpha.themes.startify").config)
    end,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
}


