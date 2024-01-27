local map = require("utils.lazy").generate_cmd_map("<leader>a", "Dadbod: ")

return {
    "kristijanhusak/vim-dadbod-ui",
    cmd = {
        "DBUI",
        "DBUIToggle",
        "DBUIAddConnection",
        "DBUIFindBuffer",
    },
    keys = {
        map("d", "n", "DBUIToggle", "Toggle")
    },
    init = function()
        vim.g.db_ui_use_nerd_fonts = 1
        vim.g.db_ui_save_location = os.getenv("XDG_CONFIG_HOME") .. "/dadbod"
        vim.g.db_ui_force_echo_notifications = 1
        vim.g.db_ui_show_help = 0
    end,
    dependencies = {
        {
            "tpope/vim-dadbod",
            cmd = "DB",
        },
        {
            "kristijanhusak/vim-dadbod-completion",
            config = function()
                vim.api.nvim_create_autocmd({ "FileType" }, {
                    pattern = { "sql", "mysql", "plsql" },
                    callback = function()
                        require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
                    end
                })
            end,
        },
    },
}
