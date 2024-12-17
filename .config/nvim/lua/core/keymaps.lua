local map = vim.keymap.set

-- Space as leader-like key
map({ 'n', 'x' }, '<Space>', '<Nop>')

-- Emacs-like cursor movement in command mode
map('c', '<C-b>', '<Left>') -- Jumps to the beginning of a line by default
map('c', '<C-f>', '<Right>') -- Opens a command-line window (q:) by default
map('c', '<C-a>', '<Home>') -- Inserts all matched candidates by default, so <C-i> is enough
map('c', '<C-d>', '<Del>') -- Lists completions by default, so <C-i> is enough
-- map("c", "<C-k>", "<c-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>") -- Digraph is important
map('c', '<C-x>', function()
	vim.fn.setreg('', vim.fn.getcmdline())
end)

-- recall history beginning with typed characters
map('c', '<C-p>', '<Up>')
map('c', '<C-n>', '<Down>')

map('i', '<C-k>', '<Nop>')
map('i', '<C-g><C-k>', '<C-k>')
map('i', '<C-v>', '<Nop>')
map('i', '<C-g><C-v>', '<C-v>')

map('n', 'x', '"_x')
map('n', 'X', '"_X')

-- Move caret on display lines
-- Comfortable line specify movement by v:count
map({ 'n', 'x' }, 'k', function()
	return vim.v.count == 0 and 'gk' or 'k'
end, { expr = true, silent = true })
map({ 'n', 'x' }, 'j', function()
	return vim.v.count == 0 and 'gj' or 'j'
end, { expr = true, silent = true })

-- word moves in only current line
local jolyne = require('jolyne')
map({ 'n', 'x' }, 'W', jolyne.W)
map({ 'n', 'x' }, 'E', jolyne.E)
map({ 'n', 'x' }, 'B', jolyne.B)
map({ 'n', 'x' }, 'gE', jolyne.gE)
map({ 'n', 'x' }, 'w', jolyne.w)
map({ 'n', 'x' }, 'e', jolyne.e)
map({ 'n', 'x' }, 'b', jolyne.b)
map({ 'n', 'x' }, 'ge', jolyne.ge)

-- Asterisk
local ast = require('asterisk-remix')
map({ 'n' }, '*', ast.keys['*'])
map({ 'n' }, '#', ast.keys['#'])
map({ 'n' }, 'g*', ast.keys['g*'])
map({ 'n' }, 'g#', ast.keys['g#'])

-- Buffer movement instead of tab's
map('n', 'gt', vim.cmd.bnext, { silent = true, desc = 'Go to the next buffer' })
map('n', 'gT', vim.cmd.bprevious, { silent = true, desc = 'Go to the previous buffer' })
map('n', '<C-Tab>', 'gt', { remap = true, silent = true, desc = 'Alias for `gt`' })
map('n', '<C-S-Tab>', 'gT', { remap = true, silent = true, desc = 'Alias for `gT`' })

-- tab movement
map('n', ']<M-t>', vim.cmd.tabnext, { silent = true, desc = 'Go to the next tab' })
map('n', '[<M-t>', vim.cmd.tabprevious, { silent = true, desc = 'Go to the previous tab' })

-- Frequently used keymaps
map('n', '<Space>w', '<Cmd>silent write<CR>', { desc = 'Write' })
map('n', '<Space>W', '<Cmd>noautocmd silent write<CR>', { desc = 'Write noautocmd' })
map('n', '<Space>d', vim.cmd.quit, { silent = true, desc = 'Quit' })
map('n', '<Space>D', vim.cmd.quitall, { silent = true, desc = 'Quit all' })
map('n', '<Space>x', function()
	require('utils.common').buffer_delete()
end, { desc = 'Delete buffer' })
map('n', '<Space>X', function()
	require('utils.common').buffer_delete('force')
end, { desc = 'Delete! buffer' })
map('n', '<Space><C-x>', function()
	require('utils.common').buffer_delete('others')
end, { desc = 'Clear buffers' })
map('n', '<C-q>', '<C-w><C-w>', { desc = 'Switch window' })

local bduf = require('center-bduf')
map({ 'n', 'x' }, '<C-d>', bduf.cd)
map({ 'n', 'x' }, '<C-u>', bduf.cu)
map({ 'n', 'x' }, '<C-f>', bduf.cf)
map({ 'n', 'x' }, '<C-b>', bduf.cb)

map('n', '<Space>sm', '<CMD>messages<CR>', { desc = 'History of messages' })

-- `ga*` keymaps
-- map('n', 'ga', '<Nop>')

map('n', '<Space>tw', function()
	vim.opt.wrap = not vim.o.wrap
	if vim.o.wrap then
		vim.notify('Wrap enabled')
	else
		vim.notify('Wrap disabled')
	end
end, { desc = 'Toggle wrap' })

map('n', '<Space>tS', function()
	vim.opt.spell = not vim.o.spell
	if vim.o.spell then
		vim.notify('Spellcheck enabled')
	else
		vim.notify('Spellcheck disabled')
	end
end, { desc = 'Toggle spell check' })

map('n', '<Space>ty', function()
	vim.opt.cursorline = not vim.o.cursorline
end, { desc = 'Toggle cursorline' })

map('n', '<Space>tY', function()
	vim.opt.cursorcolumn = not vim.o.cursorcolumn
end, { desc = 'Toggle cursorcolumn' })

map('n', '<Space>tL', function()
	vim.opt.list = not vim.o.list
end, { desc = 'Toggle list' })

map('n', '<Space>ts', function()
	vim.o.laststatus = vim.o.laststatus == 0 and 3 or 0
end, { desc = 'Toggle statusline' })

map('n', '<Space>tn', function()
	vim.opt.number = not vim.o.number
end, { desc = 'Toggle number' })

map('n', '<Space>tN', function()
	vim.opt.relativenumber = not vim.o.relativenumber
end, { desc = 'Toggle relnum' })

map('n', '<Space>tc', function()
	if vim.o.clipboard == '' then
		vim.o.clipboard = 'unnamedplus'
	else
		vim.o.clipboard = ''
	end
	vim.notify('clipboard=' .. vim.o.clipboard)
end, { desc = 'Toggle clipboard' })

local vedit_default
map('n', '<Space>tv', function()
	if not vedit_default then
		vedit_default = vim.o.virtualedit
	end
	if vim.o.virtualedit == vedit_default then
		vim.opt.virtualedit = 'all'
	else
		vim.opt.virtualedit = vedit_default
	end
	vim.notify('virtualedit=' .. vim.o.virtualedit)
end, { desc = 'Toggle virtualedit' })

map('n', '<Space>cr', ':<C-u>%s///g<Left><Left>', { desc = 'Start substitution' })
map('x', '<Space>cr', ":<C-u>'<,'>s///g<Left><Left>", { desc = 'Start substitution' })

-- sort motion
Kjuq_sort = function()
	vim.cmd([[ '[,']sort ]])
end

map('n', '<Space>cs', [[m'<Cmd>lua vim.o.operatorfunc='v:lua.Kjuq_sort'<CR>g@]], { desc = 'Sort' })
map('x', '<Space>cs', ':sort<CR>', { desc = 'Sort' })

-- variable keybinds on states
local vedit_replace = false
map({ 'n' }, 'r', function()
	return vedit_replace and 'gr' or 'r'
end, { expr = true })
map({ 'n' }, 'R', function()
	return vedit_replace and 'gR' or 'R'
end, { expr = true })
map('n', '<Space>tr', function()
	vedit_replace = not vedit_replace
	vim.notify('Virtual edit replace: ' .. tostring(vedit_replace))
end, { desc = 'Toggle vedit replace' })

-- open specific files via keymaps
map('n', '<Space>st', '<CMD>EditTodo<CR>', { desc = 'Edit todo.txt' })
map('n', '<Space>sb', '<CMD>EditBookmarks<CR>', { desc = 'Edit bookmarks.txt' })
map('n', '<Space>sr', '<CMD>EditReadinglist<CR>', { desc = 'Edit readinglist.txt' })
map('n', '<Space>sd', '<CMD>EditDailynote<CR>', { desc = 'Edit daily note' })
map('n', '<Space>ss', '<CMD>EditSnippet<CR>', { desc = 'Edit snippet' })
map('n', '<Space>sq', '<CMD>copen<CR>', { desc = 'Open QuickFix window' })

-- TODO: check if Netrw is loaded or not
map('n', '<Space>-', function()
	vim.cmd('Explore')
end, { desc = 'Open Netrw' })

local insert_date = function()
	local date = os.date('%Y-%m-%d') --[[@ as string]]
	vim.api.nvim_feedkeys(date, 'n', false)
end

local insert_time = function()
	local time = os.date('%H:%M:%S') --[[@ as string]]
	vim.api.nvim_feedkeys(time, 'n', false)
end

map('i', '<C-g>d', insert_date, { desc = 'Insert date' })
map('i', '<C-g><C-d>', insert_date, { desc = 'Insert date' })
map('i', '<C-g>t', insert_time, { desc = 'Insert time' })
map('i', '<C-g><C-t>', insert_time, { desc = 'Insert time' })

map('n', '<Esc>', function()
	vim.cmd.nohlsearch()
	vim.cmd.fclose({ bang = true })
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, false, true), 'n', false)
end, { silent = true })

map({ 'i', 's' }, '<C-l>', function()
	local mode = vim.api.nvim_get_mode().mode
	if mode == 'ix' then -- completion with <C-x>
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-l>', true, false, true), 'n', false)
	else
		vim.cmd.fclose({ bang = true })
	end
end, { silent = true })

-- LSP
-- neovim/runtime/lua/vim/lsp.lua > lsp._set_defaults
vim.keymap.set('n', 'K', '<Cmd>normal! K<CR>', { desc = 'K (Dummy to disable builtin behavior)' })
vim.keymap.set('n', 'gr', '<Nop>')
local vlb = vim.lsp.buf
map('n', 'grt', vlb.type_definition, { desc = 'LSP: Go to type definition' })
map('n', 'gri', vlb.implementation, { desc = 'LSP: Go to implementation' })
map('n', 'grd', vlb.declaration, { desc = 'LSP: Go to Declaration' })
map('n', 'grh', vlb.typehierarchy, { desc = 'LSP: Type hierarchy' })
map('n', 'grc', vlb.incoming_calls, { desc = 'LSP: Incoming calls' })
map('n', 'grg', vlb.outgoing_calls, { desc = 'LSP: Outgoing calls' })
map('n', 'grf', vlb.format, { desc = 'LSP: Format' })
map('n', '<M-e>', vim.diagnostic.open_float, { desc = 'LSP: Show diagnostics' })
map('n', 'grwa', vlb.add_workspace_folder, { desc = 'LSP: Add folder to workspace' })
map('n', 'grwr', vlb.remove_workspace_folder, { desc = 'LSP: Remove folder from workspace' })
map('n', 'grww', function()
	vim.notify(vim.inspect(vlb.list_workspace_folders()))
end, { desc = 'LSP: List folders of workspaceh' })
map('n', 'grl', vim.diagnostic.setloclist, { desc = 'LSP: Set diagnostics into loclist' })

map({ 'n', 's', 'i' }, '<C-s>', function()
	vim.lsp.buf.signature_help({
		title = ' Lsp: Signature Help ',
		border = require('utils.common').floatwinborder,
		max_width = require('utils.lsp').float_max_width,
		max_height = require('utils.lsp').float_max_height,
	})
end, { desc = 'LSP: Signature Help' })

local vt_bak
map('n', '<Space>td', function()
	vt_bak = vt_bak == nil and vim.diagnostic.config().virtual_text or vt_bak
	if vim.diagnostic.config().virtual_text then
		vim.diagnostic.config({ virtual_text = false })
	else
		vim.diagnostic.config({ virtual_text = vt_bak })
	end
end, { desc = 'LSP: Toggle virtual text of diagnotics' })
