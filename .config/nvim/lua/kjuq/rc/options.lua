local opt = vim.opt

opt.backup = true
opt.writebackup = true
opt.backupdir = os.getenv('XDG_STATE_HOME') .. '/nvim/backup//'

opt.swapfile = false
opt.autoread = true
opt.undofile = true

opt.belloff = { 'esc', 'error' }

opt.cmdheight = 0
opt.laststatus = 3 -- global status line. `0` to hide
opt.showcmdloc = 'statusline'
opt.ruler = false

opt.statusline = require('kjuq.utils.statusline')

opt.termguicolors = true

opt.wildmenu = true
opt.wildmode = { 'full' } -- use wildmenu any time
opt.wildoptions = { 'pum', 'tagfile', 'fuzzy' }
opt.completeopt = { 'menuone', 'popup' }

if vim.fn.has('nvim-0.11') == 1 then
	opt.completeopt:append('fuzzy')
end

opt.viminfo = [['1000,<50,s10,h]]

opt.sessionoptions = {
	'blank',
	'buffers',
	'folds',
	'help',
	'tabpages',
	'terminal',
	'winpos',
	'winsize',
}

opt.wildignore:append({
	'*.a',
	'*.aux',
	'*.class',
	'*.dll',
	'*.exe',
	'*.hg',
	'*.javac',
	'*.lib',
	'*.o',
	'*.obj',
	'*.orig',
	'*.out',
	'*.pyc',
	'*.pyc',
	'*.pyd',
	'*.pyo',
	'*.so',
	'*.swo',
	'*.swp',
	'*.toc',
	'.DS_Store',
	'.git',
	'node_modules',
})

opt.suffixesadd:append({ '.java', '.rs' })

-- To install on Arch `pacman -S words`
opt.dictionary:append('/usr/share/dict/words')

opt.pumheight = 10
opt.pumwidth = 40
-- o.pumblend = 20 -- Disable this when using transparent env

opt.updatetime = 200

opt.ignorecase = true
opt.smartcase = true
opt.infercase = true
opt.wildignorecase = true

opt.foldmethod = 'marker'
opt.foldopen:remove('block')
-- opt.foldtext = "v:lua.vim.treesitter.foldtext()" -- buggy and laggy?

opt.wrap = false
opt.smoothscroll = true
opt.scrolloff = 8
opt.sidescrolloff = 1

opt.startofline = true

opt.breakindent = true
-- opt.breakindentopt:append("list:-1") -- indent wrapped list
opt.showbreak = '> '

-- opt.cursorline = true
opt.cursorlineopt = { 'screenline' }

opt.splitright = true
opt.splitbelow = false

opt.virtualedit = { 'block' }

opt.smartindent = true
opt.tabstop = 4
opt.expandtab = false
opt.shiftwidth = 0 -- obey tabstop
opt.shiftround = true

opt.guicursor = table.concat({
	'n-v-sm:block-Cursor',
	'c-i-ci-ve:ver25-Cursor',
	'r-cr:hor20-Cursor',
	'o:hor50-Cursor',
	't:ver25-TermCursor',
}, ',')

opt.list = true
opt.listchars = {
	trail = '◊',
	tab = '│ ',
	-- space = "⋅",
	-- eol = "↵",
	nbsp = '▶',
	extends = '»',
	precedes = '«',
}
opt.fillchars = {
	eob = ' ', -- hide tildes in blank space after end of file
}

opt.number = false
opt.relativenumber = false
opt.numberwidth = 1

opt.helplang = { 'en', 'ja' }
opt.fileencodings = { 'ucs-bom', 'utf-8', 'sjis', 'euc-jp', 'latin1' }

opt.ttimeout = true -- `false` is buggy when SSH-ing or Wezterm without tmux
opt.timeout = false

opt.messagesopt = 'hit-enter,history:2000'

-- Disable welcome message
opt.shortmess:append('I')

opt.spell = false
opt.spellfile = vim.fs.joinpath(os.getenv('XDG_STATE_HOME'), 'nvim', 'spell.en.utf-8.add')
opt.spelllang = { 'en', 'cjk' }
opt.spelloptions = 'camel'

opt.matchpairs:append({
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
