vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.autoread = true

vim.opt.clipboard = "unnamedplus"

vim.opt.laststatus = 3 -- global status line
vim.opt.termguicolors = true
vim.opt.hlsearch = false

vim.opt.wildmenu = true
vim.opt.pumblend = 20
vim.opt.completeopt = "menuone,preview,noinsert,noselect"
vim.opt.pumheight = 10
vim.opt.pumwidth = 60

vim.opt.updatetime = 100

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.foldmethod = "marker"

vim.opt.wrap = false
vim.opt.breakindent = true

vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.expandtab = false
vim.opt.shiftwidth = 4
vim.opt.shiftround = true

vim.opt.listchars = { trail = "◊", tab = ">-", space = "⋅", eol = "󰌑" } -- "⏎"
vim.opt.list = true

vim.opt.shell = "fish"

-- Disable a leader key time out
vim.opt.timeout = false
vim.opt.ttimeout = true

