local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.loader.enable()
vim.opt.rtp:prepend(lazypath)

require("utils.common").quit_with_esc({ "lazy" })

local opts = {
    defaults = {
        lazy = true,
        -- cond = false, -- Disable a lot of plugins globally
    },
    change_detection = {
        -- automatically check for config file changes and reload the ui
        enabled = true,
        notify = false, -- get a notification when changes are found
    },
    ui = { border = "rounded" },
    performance = {
        rtp = {
            disabled_plugins = { -- shorten start up time for 1 second
                "gzip",
                "matchit",
                "matchparen",
                -- "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
}

require("lazy").setup("plugins", opts)
