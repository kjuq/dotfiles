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
	return '<Cmd>fclose<CR><Esc>'
end, { expr = true, silent = true })

vim.keymap.set({ 'i' }, '<C-l>', function()
	if vim.api.nvim_get_mode().mode ~= 'ix' then --  not in completion with <C-x>
		vim.cmd.fclose({ bang = true })
	end
end, { silent = true })

vim.keymap.set('n', '<Space>cr', ':<C-u>%s///g<Left><Left>', { desc = 'Start substitution' })
vim.keymap.set('x', '<Space>cr', ":<C-u>'<,'>s///g<Left><Left>", { desc = 'Start substitution' })

function _G.kjuq_sortmotion()
	vim.cmd([[ '[,']sort n ]])
end

vim.keymap.set('n', '<Space>cs', [[m'<Cmd>lua vim.o.operatorfunc='v:lua._G.kjuq_sortmotion'<CR>g@]], { desc = 'Sort' })
vim.keymap.set('x', '<Space>cs', ':sort n<CR>', { desc = 'Sort' }) -- NOTE: dot-register is not updated with visual mode

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

vim.keymap.set('n', 'grR', '<Cmd>lsp restart<CR><Cmd>echomsg "Done :lsp restart"<CR>', { desc = 'LSP: Restart LS' })
vim.keymap.set('n', 'grt', vlb.type_definition, { desc = 'LSP: Go to type definition' })
vim.keymap.set('n', 'grd', vlb.declaration, { desc = 'LSP: Go to Declaration' })
vim.keymap.set('n', 'grh', vlb.typehierarchy, { desc = 'LSP: Type hierarchy' })
vim.keymap.set('n', 'grc', vlb.incoming_calls, { desc = 'LSP: Incoming calls' })
vim.keymap.set('n', 'grg', vlb.outgoing_calls, { desc = 'LSP: Outgoing calls' })
vim.keymap.set('n', '<M-e>', vim.diagnostic.open_float, { desc = 'LSP: Show diagnostics' })
vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, { desc = 'LSP: Signature Help' })
-- }}}

-- LSP {{{
---@param clnt vim.lsp.Client
---@param buf integer
---@param opt table? { fix_cursor, retry }
local function register_format_on_save(clnt, buf, opt)
	if not opt then
		opt = {}
	end
	---@return boolean success or not
	local function reg()
		if clnt:supports_method(vim.lsp.protocol.Methods.textDocument_formatting) then
			vim.api.nvim_create_autocmd('BufWritePre', {
				group = vim.api.nvim_create_augroup(string.format('kjuq_formatonsave_%s_buf_%d', clnt.name, buf), {}),
				buffer = buf,
				callback = function()
					local v ---@type vim.fn.winsaveview.ret
					if opt.fix_cursor then
						v = vim.fn.winsaveview()
					end
					vim.lsp.buf.format({ async = false, id = clnt.id })
					if opt.fix_cursor then
						vim.fn.winrestview(v)
					end
				end,
			})
			return true
		end
		return false
	end
	-- Neovim currently does not support dynamic capabilities
	-- so retry several times until dynamic registration has done
	-- https://github.com/neovim/neovim/issues/24229
	local successed = reg()
	local retrynum = opt.retry or 3
	local waitms = 1000
	if not successed then
		for i = 1, retrynum do
			vim.defer_fn(function()
				if successed then
					return
				end
				successed = reg()
			end, waitms * i)
		end
	end
end

---@param selected_index integer
---@param result table
---@param client vim.lsp.Client
-- https://github.com/konradmalik/neovim-flake/blob/644fe3df84dc3cf51a7d5ab2df29817ff7d6100d/config/nvim/lua/pde/lsp/capabilities/textDocument_completion.lua
local function show_documentation(selected_index, result, client)
	local docs = vim.tbl_get(result, 'documentation', 'value')
	if not docs then
		return
	end
	local wininfo = vim.api.nvim__complete_set(selected_index, { info = docs .. '\n\n_client: ' .. client.name .. '_' })
	if vim.tbl_isempty(wininfo) or not vim.api.nvim_win_is_valid(wininfo.winid) then
		return
	end
	vim.wo[wininfo.winid].conceallevel = 2
	vim.wo[wininfo.winid].concealcursor = 'n'
	if not vim.api.nvim_buf_is_valid(wininfo.bufnr) then
		return
	end
	vim.bo[wininfo.bufnr].syntax = 'markdown'
	vim.treesitter.start(wininfo.bufnr, 'markdown')
end

local documentation_is_enabled = true
---@param client vim.lsp.Client
---@param bufnr integer
local function register_completion_documentation(client, bufnr)
	if not client:supports_method(vim.lsp.protocol.Methods.completionItem_resolve) then
		return
	end
	local _, cancel_prev = nil, function() end
	vim.api.nvim_create_autocmd('CompleteChanged', {
		group = vim.api.nvim_create_augroup(
			string.format('kjuq_completion_documentation_%s_buf_%d', client.name, bufnr),
			{}
		),
		buffer = bufnr,
		callback = function()
			cancel_prev()
			if not documentation_is_enabled then
				return
			end
			local completion_item = vim.tbl_get(vim.v.completed_item, 'user_data', 'nvim', 'lsp', 'completion_item')
			if not completion_item then
				return
			end
			local complete_info = vim.fn.complete_info({ 'selected' })
			if vim.tbl_isempty(complete_info) then
				return
			end
			local selected_index = complete_info.selected
			_, cancel_prev = vim.lsp.buf_request(
				bufnr,
				vim.lsp.protocol.Methods.completionItem_resolve,
				completion_item,
				function(err, item)
					if err ~= nil then
						-- vim.notify(
						-- 	'Error from client ' .. client.name .. ' when getting documentation\n' .. vim.inspect(err),
						-- 	vim.log.levels.WARN
						-- )
						-- at this stage just disable it
						documentation_is_enabled = false
						return
					end
					if not item then
						return
					end
					show_documentation(selected_index, item, client)
				end
			)
		end,
	})
end

---@param client vim.lsp.Client
---@param bufnr integer
local function register_inlinecompletion(client, bufnr)
	vim.keymap.set('i', '<C-a>', vim.lsp.inline_completion.get, { desc = 'Get the current inline completion' })
	if client:supports_method('textDocument/inlineCompletion') then
		-- https://github.com/neovim/nvim-lspconfig/pull/4029
		-- To sign-in `:LspCopilotSignIn`
		vim.keymap.set('n', '<Space>ti', function()
			vim.lsp.inline_completion.enable(true, { bufnr = bufnr })
		end, { buffer = bufnr, desc = 'Enable inline completion' })
		vim.keymap.set('n', '<Space>tI', function()
			vim.lsp.inline_completion.enable(false, { bufnr = bufnr })
		end, { buffer = bufnr, desc = 'Disable inline completion' })
	end
end

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

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('kjuq_user_lsp_config', {}),
	callback = function(ev)
		local bufnr = ev.buf
		-- Buffer-local keymaps
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP: Go to definition', buffer = bufnr })
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
		register_format_on_save(client, bufnr, {
			fix_cursor = vim.tbl_contains({ 'efm' }, client.name),
		})
		if vim.fn.has('nvim-0.12') == 1 then
			vim.opt.complete = 'o'
			register_inlinecompletion(client, bufnr)
		end
		register_completion_documentation(client, bufnr)
	end,
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

if os.getenv('KJUQ_NVIM_LOAD_ALL_RUNTIME_PATH') then
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
end
-- }}}

-- vim: set foldmethod=marker :
