vim.opt.backup = true
vim.opt.backupdir = os.getenv('XDG_STATE_HOME') .. '/nvim/backup//'
vim.opt.undofile = true

vim.opt.belloff = { 'esc', 'error' }

vim.opt.cmdheight = 0
vim.opt.laststatus = 0 -- global status line. `0` to hide
vim.opt.statusline = require('kjuq.utils.statusline').statusline

vim.opt.showcmdloc = 'statusline'
vim.opt.ruler = false

-- vim.opt.wildoptions = { 'pum', 'tagfile', 'fuzzy' }
vim.opt.wildoptions:append('fuzzy')
vim.opt.completeopt = { 'menuone', 'popup', 'fuzzy' }

vim.opt.winborder = 'single'

vim.opt.dictionary:append('/usr/share/dict/words') -- For Archlinux, `pacman -S words`

vim.opt.pumheight = 10
vim.opt.pumwidth = 40
-- o.pumblend = 20 -- Disable this when using transparent env

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.infercase = true
vim.opt.wildignorecase = true

vim.opt.foldmethod = 'expr'
vim.opt.foldopen:remove('block')
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldtext = ''
vim.opt.foldlevel = 9999

vim.opt.wrap = false
vim.opt.wrapscan = true
vim.opt.smoothscroll = true
-- vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 1

vim.opt.startofline = true

vim.opt.autoindent = true
vim.opt.smartindent = false -- DON'T ENABLE THIS so that '#' at the beginning of a line be indented properly
vim.opt.cindent = true
vim.opt.cinkeys:remove('0#')
vim.opt.cinoptions:append('j9') -- `:help java-cinoptions`
vim.opt.cinoptions:append('J9') -- `:help javascript-cinoptions`
vim.opt.breakindent = true
-- vim.opt.breakindentopt:append("list:-1") -- indent wrapped list
vim.opt.showbreak = '> '

vim.opt.cursorlineopt = { 'screenline' }

vim.opt.splitright = true
vim.opt.splitbelow = false

vim.opt.virtualedit = { 'block' }

vim.opt.tabstop = 4
vim.opt.expandtab = false
vim.opt.shiftwidth = 0 -- obey tabstop
vim.opt.shiftround = true

vim.opt.list = true
vim.opt.listchars = {
	trail = '◊',
	tab = '│ ',
	nbsp = '▶',
}

vim.opt.numberwidth = 1

vim.opt.timeout = false

vim.opt.exrc = true

vim.opt.spelllang = { 'en', 'cjk' }

vim.opt.matchpairs:append({
	'「:」',
	'（:）',
	'［:］',
	'〔:〕',
	'【:】',
	'『:』',
	'｛:｝',
	'“:”',
	'‘:’',
})
