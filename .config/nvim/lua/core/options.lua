local opt = vim.opt

opt.backup = true
opt.writebackup = true
opt.backupdir = os.getenv("XDG_STATE_HOME") .. "/nvim/backup//"

opt.swapfile = false
opt.autoread = true

opt.cmdheight = 0
opt.laststatus = 3 -- global status line
opt.showcmdloc = "statusline"

opt.termguicolors = true

opt.wildmenu = true
opt.completeopt = "menuone,popup,noselect,fuzzy"

-- To install on Arch `pacman -S words`
opt.dictionary:append("/usr/share/dict/words")

opt.pumheight = 10
opt.pumwidth = 40
-- o.pumblend = 20 -- Disable this when using transparent env

opt.updatetime = 200

opt.ignorecase = true
opt.smartcase = true
opt.infercase = true

opt.foldmethod = "marker"
opt.foldopen:remove("block")
-- opt.foldtext = "v:lua.vim.treesitter.foldtext()" -- buggy and laggy?

opt.wrap = false
opt.smoothscroll = true
opt.scrolloff = 8
opt.startofline = true

opt.breakindent = true
-- opt.breakindentopt:append("list:-1") -- indent wrapped list
opt.showbreak = "> "

-- opt.cursorline = true
opt.cursorlineopt = { "screenline" }

opt.splitright = true

opt.virtualedit = { "block" }

opt.smartindent = true
opt.tabstop = 4
opt.expandtab = false
opt.shiftwidth = 0 -- obey tabstop
opt.shiftround = true

opt.list = true
opt.listchars = {
	trail = "◊",
	tab = "│ ",
	-- space = "⋅",
	-- eol = "↵",
	nbsp = "▶",
	extends = "»",
	precedes = "«",
}
opt.fillchars = {
	eob = " ", -- hide tildes in blank space after end of file
}

opt.number = true
opt.relativenumber = false
opt.numberwidth = 1

opt.helplang = { "en", "ja" }
opt.fileencodings = { "ucs-bom", "utf-8", "sjis", "euc-jp", "latin1" }

-- Disable a leader key time out (buggy when ssh-ing KSGO from KMMN)
opt.timeout = false
opt.ttimeout = false

-- Disable welcome message
opt.shortmess:append("I")

opt.spell = false
opt.spellfile = vim.fs.joinpath(os.getenv("XDG_STATE_HOME"), "nvim", "spell.en.utf-8.add")
opt.spelllang = "en,cjk"
opt.spelloptions = "camel"

opt.matchpairs:append("「:」")
opt.matchpairs:append("（:）")
opt.matchpairs:append("［:］")
opt.matchpairs:append("〔:〕")
opt.matchpairs:append("【:】")
opt.matchpairs:append("『:』")
opt.matchpairs:append("｛:｝")
