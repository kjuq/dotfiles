local skk = require("utils.skk")
local map = require("utils.lazy").generate_map("", "Eskk: ")

local toggle_japanese = function()
    skk.toggle_japanese(function()
        require("utils.common").feed_plug("eskk:enable")
    end)
end

return {
    "vim-skk/eskk.vim",
    cond = vim.fn.executable("deno") == 0 and skk.jisyo_l_exists(), -- fallen-back from skkeleton
    keys = {
        map("<C-Space>", { "i", "c" }, function() require("utils.common").feed_plug("eskk:enable") end, "Enable"),
        map("<leader>aj", "n", function() toggle_japanese() end, "Toggle JP mode"),
    },
    config = function()
        vim.g["eskk#directory"] = skk.skk_dir
        vim.g["eskk#dictionary"] = { path = skk.jisyo_user, sorted = 1, encoding = "utf-8" }
        vim.g["eskk#large_dictionary"] = { path = skk.jisyo_l, sorted = 1, encoding = "euc-jp" }
        vim.g["eskk#egg_like_newline"] = 1
        vim.g["eskk#keep_state"] = 0
        vim.g["eskk#enable_completion"] = 0
        vim.g["eskk#no_default_mappings"] = 1

        vim.api.nvim_create_autocmd("user", {
            pattern = "eskk-initialize-pre",
            callback = function()
                vim.cmd([[ let t = eskk#table#new("rom_to_hira*", "rom_to_hira") ]])
                vim.cmd([[ call t.add_map("!", "!") ]])
                vim.cmd([[ call t.add_map("?", "?") ]])
                vim.cmd([[ call t.add_map(":", ":") ]])
                vim.cmd([[ call t.add_map("z ", "　") ]])
                vim.cmd([[ call eskk#register_mode_table("hira", t) ]])
            end,
        })

        local has_cmp, cmp = pcall(require, "cmp")
        local has_noice, _ = pcall(require, "noice")
        vim.api.nvim_create_autocmd("user", {
            pattern = "eskk-enable-pre",
            callback = function()
                if has_noice then
                    vim.cmd("Noice disable")
                end
                if has_cmp then
                    cmp.setup({ sources = cmp.config.sources({}) })
                end
            end,
        })
        vim.api.nvim_create_autocmd("user", {
            pattern = "eskk-disable-post",
            callback = function()
                if has_noice then
                    vim.cmd("Noice enable")
                end
                if has_cmp then
                    require("plugins.cmp").config()
                end
            end,
        })
    end,
}
