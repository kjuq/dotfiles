if vim.uv.getuid() == 0 then
	vim.notify('Neovim is running as a super user. Loading configurations was skipped.')
	return
end

vim.loader.enable()

-- Options {{{
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
--- }}}

-- Keymaps {{{
vim.keymap.set({ 'n', 'x' }, '<Space>', '<Nop>')

-- Emacs-like cursor movement in command mode
vim.keymap.set('c', '<C-b>', '<Left>') -- Jumps to the beginning of a line by default
vim.keymap.set('c', '<C-f>', '<Right>') -- Opens a command-line window (q:) by default
vim.keymap.set('c', '<C-a>', '<Home>') -- Inserts all matched candidates by default, so <C-i> is enough
vim.keymap.set('c', '<C-d>', '<Del>') -- Lists completions by default, so <C-i> is enough
-- map("c", "<C-k>", "<c-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>") -- Digraph is important
vim.keymap.set('c', '<C-x>', function()
	vim.fn.setreg('', vim.fn.getcmdline())
end)

-- recall history beginning with typed characters
vim.keymap.set('c', '<C-p>', function()
	return vim.fn.pumvisible() == 0 and '<Up>' or '<C-p>'
end, { expr = true })
vim.keymap.set('c', '<C-n>', function()
	return vim.fn.pumvisible() == 0 and '<Down>' or '<C-n>'
end, { expr = true })

vim.keymap.set('i', '<C-k>', '<Nop>')
vim.keymap.set('i', '<C-g><C-k>', '<C-k>')
vim.keymap.set('i', '<C-v>', '<Nop>')
vim.keymap.set('i', '<C-g><C-v>', '<C-v>')

vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('n', 'X', '"_X')

vim.keymap.set('i', '<C-y>', function()
	local mode = vim.api.nvim_get_mode().mode
	if mode ~= 'ic' then
		return '<C-y>'
	end
	local selected = vim.fn.complete_info({ 'selected' }).selected ~= -1
	if not selected then
		return '<C-n><C-y>'
	else
		return '<C-y>'
	end
end, { expr = true })

-- Move caret on display lines
-- Comfortable line specify movement by v:count
vim.keymap.set({ 'n', 'x' }, 'k', function()
	return vim.v.count == 0 and 'gk' or 'k'
end, { expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'j', function()
	return vim.v.count == 0 and 'gj' or 'j'
end, { expr = true, silent = true })

vim.keymap.set('n', '<Esc>', function()
	vim.cmd.nohlsearch()
	return '<Esc>'
end, { expr = true, silent = true })

vim.keymap.set({ 'i' }, '<C-l>', function()
	if vim.api.nvim_get_mode().mode ~= 'ix' then --  not in completion with <C-x>
		vim.cmd.fclose({ bang = true })
	end
end, { silent = true })

vim.keymap.set('n', '<Space>cr', ':<C-u>%s///g<Left><Left>', { desc = 'Start substitution' })
vim.keymap.set('x', '<Space>cr', ":<C-u>'<,'>s///g<Left><Left>", { desc = 'Start substitution' })

vim.keymap.set('n', '<Space>cv', '`[v`]', { desc = 'Select last pasted range' })

vim.keymap.set('n', '<Space>sq', '<CMD>copen<CR>', { desc = 'Open QuickFix window' })
vim.keymap.set('n', '<Space>sm', '<CMD>messages<CR>', { desc = 'History of messages' })

vim.keymap.set('n', '<space>am', function()
	vim.ui.input({ prompt = '$ ', completion = 'shellcmdline' }, function(c)
		if c and c ~= '' then
			vim.cmd('noswapfile enew')
			vim.bo.buftype = 'nofile'
			-- vim.bo.bufhidden = 'wipe'
			vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.systemlist(c))
		end
	end)
end)

-- Frequently used keymaps
vim.keymap.set('n', '<Space>w', vim.cmd.write, { desc = 'Write' })
vim.keymap.set('n', '<Space>d', vim.cmd.quit, { desc = 'Quit' })

vim.keymap.set('n', '<Space>-', '<Cmd>Explore<CR>', { desc = ':Explore' })

vim.keymap.set('t', '<S-Tab>', [[<C-\><C-n>]], { desc = 'Exit insert mode' })

-- LSP:
-- neovim/runtime/lua/vim/lsp.lua > lsp._set_defaults
vim.keymap.set('n', 'gr', '<Nop>')

local vlb = vim.lsp.buf

vim.keymap.set('n', 'grR', '<Cmd>LspRestart<CR><Cmd>echomsg "Done :LspRestart"<CR>', { desc = 'LSP: Restart LS' })
vim.keymap.set('n', 'grt', vlb.type_definition, { desc = 'LSP: Go to type definition' })
vim.keymap.set('n', 'grd', vlb.declaration, { desc = 'LSP: Go to Declaration' })
vim.keymap.set('n', 'grh', vlb.typehierarchy, { desc = 'LSP: Type hierarchy' })
vim.keymap.set('n', 'grc', vlb.incoming_calls, { desc = 'LSP: Incoming calls' })
vim.keymap.set('n', 'grg', vlb.outgoing_calls, { desc = 'LSP: Outgoing calls' })
vim.keymap.set({ 'n', 'x' }, 'grf', vlb.format, { desc = 'LSP: Format' })
vim.keymap.set('n', '<M-e>', vim.diagnostic.open_float, { desc = 'LSP: Show diagnostics' })
vim.keymap.set('n', 'grwa', vlb.add_workspace_folder, { desc = 'LSP: Add folder to workspace' })
vim.keymap.set('n', 'grwr', vlb.remove_workspace_folder, { desc = 'LSP: Remove folder from workspace' })
vim.keymap.set('n', 'grww', function()
	vim.notify(vim.inspect(vlb.list_workspace_folders()))
end, { desc = 'LSP: List folders of workspaceh' })
vim.keymap.set('n', 'grq', vim.diagnostic.setqflist, { desc = 'LSP: Set diagnostics into qflist' })

-- NOTE: There are few LSP which supports `workspace/diagnostic` though
if vim.fn.has('nvim-0.12') == 1 then
	vim.keymap.set('n', 'grwq', vim.lsp.buf.workspace_diagnostics, { desc = 'LSP: Workspace diagnostics' })
end
vim.keymap.set(
	'n',
	'grwo',
	require('kjuq.lsp_module').workspace_didopen,
	{ desc = 'LSP: Send `textDocument/didOpen` for all files' }
)

vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, { desc = 'LSP: Signature Help' })
-- }}}

-- LSP {{{
vim.diagnostic.config({
	signs = false,
	float = {
		max_width = 80,
		max_height = 20,
		header = '',
		format = function(diagnostic)
			return string.format('%s\n⊳ %s', diagnostic.message, diagnostic.source)
		end,
	},
	jump = {
		float = true,
	},
})

---@param ev table ref. `help event-args`
local on_attach = function(ev)
	local bufnr = ev.buf

	-- Buffer-local keymaps
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP: Go to definition', buffer = bufnr })
	if vim.fn.has('nvim-0.12') == 1 then
		vim.keymap.set(
			'n',
			'grQ',
			vim.lsp.buf.workspace_diagnostics,
			{ desc = 'LSP: Workspace diagnostics', buffer = bufnr }
		)
	end
	local vl_enabled = false
	vim.keymap.set('n', '<M-l>', function()
		vim.diagnostic.config({
			virtual_lines = not vl_enabled and { current_line = true } or false,
		})
		vl_enabled = not vl_enabled
		-- TODO: disable when cursor moved beyond lines
	end, { desc = 'LSP: Toggle virtual lines of diagnostic' })

	local client_id = ev.data.client_id
	local client = assert(vim.lsp.get_client_by_id(client_id))

	require('kjuq.lsp_module').register_format_on_save(client, bufnr, {
		fix_cursor = vim.tbl_contains({ 'efm' }, client.name),
	})
	if vim.fn.has('nvim-0.12') == 1 then
		require('kjuq.lsp_module').register_autocompletion(client, bufnr, false, false)
		require('kjuq.lsp_module').register_inlinecompletion(client, bufnr)
	end
	require('kjuq.lsp_module').register_completion_documentation(client, bufnr)
end

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('kjuq_user_lsp_config', {}),
	callback = on_attach,
})
-- }}}

-- Lazy {{{
if os.getenv('KJUQ_NVIM_NO_EXT_PLUGINS') == '1' then
	return
end

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
			{ out, 'WarningMsg' },
			{ '\nPress any key to exit...' },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

---@type LazyConfig
local opts = {
	defaults = {
		lazy = true,
	},
	change_detection = {
		-- automatically check for config file changes and reload the ui
		enabled = true,
		notify = false, -- get a notification when changes are found
	},
	concurrency = vim.uv.available_parallelism() * 2,
	ui = { border = vim.o.winborder },
	dev = {
		---@param spec LazyPlugin
		path = function(spec)
			local dir = spec.url:gsub('^http[s]+://', ''):gsub([[.git$]], '')
			return vim.fs.joinpath(os.getenv('GHQ_ROOT'), dir)
		end,
		patterns = { 'kjuq' },
		fallback = true,
	},
}

require('lazy').setup('plugins', opts) -- to load multiple dir https://zenn.dev/sisi0808/articles/36ff184554ddd6

if not os.getenv('KJUQ_NVIM_LOAD_ALL_RUNTIME_PATH') then
	return
end
local library = {
	vim.fs.joinpath(vim.env.VIMRUNTIME, '/lua'),
	vim.fs.joinpath(vim.fn.stdpath('config'), '/lua'),
}
for _, v in pairs(require('lazy.core.config').plugins) do
	library[#library + 1] = vim.fs.joinpath(v.dir, '/lua')
end
vim.lsp.config.lua_ls = {
	settings = {
		Lua = {
			workspace = {
				library = library,
			},
		},
	},
}
-- }}}

-- vim: set foldmethod=marker :
