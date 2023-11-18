local jp_enabled = false
local jp_toggle = vim.api.nvim_create_augroup("JpToggleGroup", {})

local toggle_japanese = function()
    if jp_enabled then
        print("Japanese mode disabled")
        vim.api.nvim_clear_autocmds({ group = jp_toggle })
    else
        print("Japanese mode enabled")
        vim.api.nvim_create_autocmd("InsertEnter", {
            group = jp_toggle,
            pattern = "*",
            callback = function()
                require("utils.common").feed_plug("(skkeleton-enable)")
            end
        })
    end
    jp_enabled = not jp_enabled
end

return {
    "vim-skk/skkeleton",
    event = { "InsertEnter" },
    keys = {
        { "<C-Space>",  mode = { "i", "c" }, "<Plug>(skkeleton-enable)", desc = "SKK: Enable",              noremap = false, silent = true },
        { "<leader>aj", mode = { "n" },      toggle_japanese,            desc = "SKK: Toggle Japanese mode" },
    },
    config = function()
        local jisyo_l = os.getenv("HOMEBREW_PREFIX") .. "/share/skk-jisyo-l/SKK-JISYO.L"

        vim.fn["skkeleton#config"]({
            eggLikeNewline = true,
            globalJisyo = jisyo_l,
        })

        vim.fn["skkeleton#register_kanatable"]("rom", {
            ["!"] = { "!", "" },
            ["?"] = { "?", "" },
            [":"] = { ":", "" },
        })
    end,
    dependencies = {
        "vim-denops/denops.vim",
        {
            "delphinus/skkeleton_indicator.nvim",
            opts = {
                alwaysShown = false,
                zindex = 9999,
            },
        },
    },
}
