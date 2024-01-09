local skk = require("utils.skk")
local map = require("utils.lazy").generate_map("", "Skkeleton: ")

local toggle_japanese = function()
    skk.toggle_japanese(function()
        require("utils.common").feed_plug("skkeleton-enable")
    end)
end

return {
    "vim-skk/skkeleton",
    cond = vim.fn.executable("deno") ~= 0 and skk.jisyo_l_exists(),
    event = { "InsertEnter" },
    keys = {
        map("<C-Space>", { "i", "c" }, function() require("utils.common").feed_plug("skkeleton-enable") end, "Enable"),
        map("<leader>aj", "n", function() toggle_japanese() end, "Toggle JP mode"),
    },
    config = function()
        -- create $XDG_CONFIG_HOME/skk dir if it doesn't exist
        if vim.fn.isdirectory(skk.skk_dir) == 0 then
            vim.fn.mkdir(skk.skk_dir, "p")
        end

        vim.fn["skkeleton#config"]({
            eggLikeNewline = true,
            globalJisyo = skk.jisyo_l,
            userJisyo = skk.jisyo_user,
        })

        vim.fn["skkeleton#register_kanatable"]("rom", {
            ["!"] = { "!", "" },
            ["?"] = { "?", "" },
            [":"] = { ":", "" },
        })
    end,
    dependencies = {
        "vim-denops/denops.vim",
        "uga-rosa/cmp-skkeleton",
        {
            "delphinus/skkeleton_indicator.nvim",
            opts = {
                alwaysShown = false,
                zindex = 9999,
            },
        },
    },
}
