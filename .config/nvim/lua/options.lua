vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.autoread = true

vim.opt.scrolloff = 6

vim.opt.clipboard = "unnamedplus"

vim.opt.cmdheight = 0
vim.opt.laststatus = 3 -- global status line
vim.opt.termguicolors = true

vim.opt.wildmenu = true
vim.opt.completeopt = "menuone,preview,noinsert,noselect"
vim.opt.pumheight = 10
vim.opt.pumwidth = 60
-- vim.opt.pumblend = 20 -- Disable this when using transparent env

vim.opt.updatetime = 100

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.foldmethod = "marker"

vim.opt.wrap = false
vim.opt.smoothscroll = true
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
vim.opt.ttimeout = false

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.netrw_fastbrowse = 0
