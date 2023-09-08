vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.wildmenu = true
vim.opt.autoread = true
vim.opt.clipboard = "unnamedplus"
vim.opt.wrap = false
vim.opt.laststatus = 3 -- global status line
vim.opt.termguicolors = true

vim.opt.updatetime = 500

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.foldmethod = "marker"

vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.shiftround = true

vim.opt.listchars = { trail = "◊", tab = ">-" } -- { space = "⋅" }
vim.opt.list = true

vim.opt.shell = "fish"

-- Disable a leader key time out
vim.opt.timeout = false
vim.opt.ttimeout = true

