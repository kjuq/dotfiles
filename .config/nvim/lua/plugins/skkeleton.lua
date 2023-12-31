local skk = require("utils.skk")

local opts = { enabled = false }
local jp_toggle = vim.api.nvim_create_augroup("SkkeletonToggle", {})

local toggle_japanese = function()
    skk.toggle_japanese(opts, jp_toggle, function()
        require("utils.common").feed_plug("(skkeleton-enable)")
    end)
end

return {
    "vim-skk/skkeleton",
    cond = vim.fn.executable("deno") ~= 0,
    event = { "InsertEnter" },
    keys = {
        { "<C-Space>",  mode = { "i", "c" }, "<Plug>(skkeleton-enable)", desc = "Skkeleton: Enable",        noremap = false, silent = true },
        { "<leader>aj", mode = { "n" },      toggle_japanese,            desc = "Skkeleton: Toggle JP mode" },
    },
    config = function()
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
