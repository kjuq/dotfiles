local o          = vim.opt

o.backup         = false
o.writebackup    = false
o.swapfile       = false
o.autoread       = true

o.scrolloff      = 6

o.clipboard      = "unnamedplus"

o.cmdheight      = 0
o.laststatus     = 3 -- global status line
o.termguicolors  = true

o.wildmenu       = true
o.completeopt    = "menu,menuone,preview,noinsert"

o.pumheight      = 10
o.pumwidth       = 40
-- o.pumblend = 20 -- Disable this when using transparent env

o.updatetime     = 100

o.ignorecase     = true
o.smartcase      = true

o.foldmethod     = "marker"

o.wrap           = false
o.smoothscroll   = true
o.breakindent    = true

o.virtualedit    = { "onemore", "block" }

o.smartindent    = true
o.tabstop        = 4
o.expandtab      = false
o.shiftwidth     = 0 -- obey tabstop
o.shiftround     = true

o.listchars      = { trail = "◊", tab = "│⋅", space = "⋅", eol = "↵" }
o.list           = true
o.relativenumber = true
vim.o.fillchars  = "eob: " -- hide tildes in blank space after end of file

o.helplang       = { "en", "ja" }

-- Disable a leader key time out
o.timeout        = false
o.ttimeout       = false

-- Disable welcome message
o.shortmess:append("I")
