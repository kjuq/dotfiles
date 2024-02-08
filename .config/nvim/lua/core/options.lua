local opt          = vim.opt

opt.backup         = true
opt.writebackup    = true
opt.backupdir      = os.getenv("XDG_STATE_HOME") .. "/nvim/backup//"

opt.swapfile       = false
opt.autoread       = true

-- opt.scrolloff      = 6

opt.clipboard      = "unnamedplus"

opt.cmdheight      = 0
opt.laststatus     = 3 -- global status line
opt.showcmdloc     = "statusline"

opt.termguicolors  = true

opt.wildmenu       = true
opt.completeopt    = "menu,menuone,preview,noinsert"

opt.pumheight      = 10
opt.pumwidth       = 40
-- o.pumblend = 20 -- Disable this when using transparent env

opt.updatetime     = 200

opt.ignorecase     = true
opt.smartcase      = true

opt.foldmethod     = "marker"
-- opt.foldtext       = "v:lua.vim.treesitter.foldtext()" -- laggy

opt.wrap           = false
opt.smoothscroll   = true
opt.breakindent    = true

opt.cursorline     = true
opt.cursorlineopt  = { "screenline" }

opt.splitright     = true

opt.virtualedit    = { "block" }

opt.smartindent    = true
opt.tabstop        = 4
opt.expandtab      = false
opt.shiftwidth     = 0 -- obey tabstop
opt.shiftround     = true

opt.listchars      = { trail = "◊", tab = "│⋅", space = "⋅", eol = "↵", nbsp = "▶", extends = "»", precedes = "«" }
opt.list           = true
opt.fillchars      = "eob: " -- hide tildes in blank space after end of file

opt.number         = false
opt.relativenumber = true
opt.numberwidth    = 1

opt.helplang       = { "en", "ja" }
opt.fileencodings  = { "ucs-bom", "utf-8", "sjis", "euc-jp", "latin1" }

-- Disable a leader key time out
opt.timeout        = false
opt.ttimeout       = false

-- Disable welcome message
opt.shortmess:append("I")

opt.matchpairs:append("「:」")
opt.matchpairs:append("（:）")
opt.matchpairs:append("［:］")
opt.matchpairs:append("〔:〕")
opt.matchpairs:append("【:】")
opt.matchpairs:append("『:』")
opt.matchpairs:append("｛:｝")
