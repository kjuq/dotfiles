-- skkeleton makes startuptime longer even load it lazily

local skk = require("utils.skk")
local map = require("utils.lazy").generate_map("", "Skkeleton: ")

local toggle_japanese = function()
    skk.toggle_japanese(function()
        require("utils.common").feed_plug("skkeleton-enable")
    end)
end

return {
    "vim-skk/skkeleton",
    cond = vim.fn.executable("deno") ~= 0,
    keys = {
        map("<C-Space>", { "i", "c" }, function() require("utils.common").feed_plug("skkeleton-toggle") end, "Toggle"),
        map("<leader>aj", "n", function() toggle_japanese() end, "Toggle JP mode"),
        map("<F19>", { "i", "c" }, function() require("utils.common").feed_plug("skkeleton-enable") end, "Enable"),
        map("<F18>", { "i", "c" }, function() require("utils.common").feed_plug("skkeleton-disable") end, "Disable"),
    },
    config = function()
        -- create $XDG_CONFIG_HOME/skk dir if it doesn't exist
        if vim.fn.isdirectory(skk.skk_dir) == 0 then
            vim.fn.mkdir(skk.skk_dir, "p")
        end

        local lazy_root = require("lazy.core.config").options.root

        vim.fn["skkeleton#config"]({
            eggLikeNewline = true,
            setUndoPoint = false,
            globalDictionaries = {
                vim.fs.joinpath(lazy_root, "dict", "SKK-JISYO.L"),
                vim.fs.joinpath(lazy_root, "dict", "SKK-JISYO.jinmei"),
            },
            userDictionary = skk.jisyo_user,
        })

        vim.fn["skkeleton#register_kanatable"]("rom", {
            ["!"] = { "!", "" },
            ["?"] = { "?", "" },
            [":"] = { ":", "" },
        })

        vim.fn["skkeleton#register_keymap"]("input", "<C-g>", "")
        vim.fn["skkeleton#register_keymap"]("henkan", "<C-g>", "")
        vim.cmd("call add(g:skkeleton#mapped_keys, '<C-c>')")
        vim.fn["skkeleton#register_keymap"]("input", "<C-c>", "cancel")
        vim.fn["skkeleton#register_keymap"]("henkan", "<C-c>", "cancel")

        -- remove "<C-g>" from mapped_keys
        local mapped_keys = {}
        for _, v in ipairs(vim.g["skkeleton#mapped_keys"]) do
            if v ~= "<C-g>" then
                table.insert(mapped_keys, v)
            end
        end
        vim.g["skkeleton#mapped_keys"] = mapped_keys
    end,
    dependencies = {
        "vim-denops/denops.vim",
        "skk-dev/dict",
        { "uga-rosa/cmp-skkeleton", cond = pcall(require, "cmp") },
        {
            "delphinus/skkeleton_indicator.nvim",
            opts = {
                alwaysShown = false,
                zindex = 9999,
            },
        },
    },
}
