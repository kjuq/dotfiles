vim.opt.backup = true
vim.opt.backupdir = os.getenv('XDG_STATE_HOME') .. '/nvim/backup//'
vim.opt.undofile = true

vim.opt.belloff = { 'esc', 'error' }

vim.opt.cmdheight = 0
vim.opt.laststatus = 0 -- global status line. `0` to hide
vim.opt.statusline = require('kjuq.statusline').statusline

vim.opt.showcmdloc = 'statusline'
vim.opt.ruler = false

-- vim.opt.wildoptions = { 'pum', 'tagfile', 'fuzzy' }
vim.opt.wildoptions:append('fuzzy')
vim.opt.completeopt = { 'noselect', 'menuone', 'popup', 'fuzzy' }

-- -- <C-n>/<C-p> の keyword 補完だけは候補を選択せずに開く
-- vim.keymap.set('i', '<C-n>', '<Cmd>setglobal completeopt+=noselect<CR><C-n>')
-- vim.keymap.set('i', '<C-p>', '<Cmd>setglobal completeopt+=noselect<CR><C-p>')
--
-- -- 補完が終わったら戻す (次に使う <C-x> 系補完を select に保つ)
-- vim.api.nvim_create_autocmd('CompleteDone', {
-- 	group = vim.api.nvim_create_augroup('kjuq_cn_noselect', {}),
-- 	callback = function()
-- 		vim.opt_global.completeopt:remove('noselect')
-- 	end,
-- })

vim.opt.dictionary:append('/usr/share/dict/words') -- For Archlinux, `pacman -S words`

vim.opt.winborder = 'single'

vim.opt.pumheight = 7
vim.opt.pumwidth = 40
vim.opt.pumborder = vim.o.winborder
-- o.pumblend = 20 -- Disable this when using transparent env

-- HACK: ドキュメントポップアップに無理やりボーダーを付ける (https://www.pandanoir.info/entry/2026/04/19/095000#%E8%A8%AD%E5%AE%9A%E6%96%B9%E6%B3%95)
-- 現状 winborder や completeopt=popup だけではドキュメントfloatのボーダーを制御できない (https://github.com/neovim/neovim/issues/38248)
-- 将来的に completepopup オプション等が実装されればこのワークアラウンドは不要になる
local orig_complete_set = vim.api.nvim__complete_set
---@diagnostic disable-next-line: duplicate-set-field
vim.api.nvim__complete_set = function(...)
	local result = orig_complete_set(...)
	if result and result.winid then
		pcall(vim.api.nvim_win_set_config, result.winid, { border = 'rounded' })
	end
	return result
end

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
vim.opt.cindent = false
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
