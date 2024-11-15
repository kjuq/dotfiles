local map = vim.keymap.set

-- Space as leader key
map({ 'n', 'x' }, '<Space>', '<Nop>')

-- Disable Ctrl-c to allow <C-c> keymappings (e.g. <C-w><C-c>, etc
-- map('n', '<C-c>', '<Nop>')

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
map('n', ']T', vim.cmd.tabnext, { silent = true, desc = 'Go to the next tab' })
map('n', '[T', vim.cmd.tabprevious, { silent = true, desc = 'Go to the previous tab' })
map('n', 'zT', vim.cmd.tabclose, { silent = true, desc = 'Close current tab page' })

-- Quickfix
map('n', ']l', vim.cmd.cnext, { desc = 'Next location on QuickFix' })
map('n', '[l', vim.cmd.cprevious, { desc = 'Previous location on QuickFix' })

-- Frequently used keymaps
local write = function(key)
	map('n', key, '<Cmd>silent write<CR>', { desc = 'Write' })
end
local write_noautocmd = function(key)
	map('n', key, '<Cmd>noautocmd silent write<CR>', { desc = 'Write w/o autocmd' })
end
local quit = function(key)
	map('n', key, vim.cmd.quit, { silent = true, desc = 'Quit' })
end
local quit_force = function(key)
	map('n', key, function()
		vim.cmd.quit({ bang = true })
	end, { silent = true, desc = 'Force quit' })
end

write('gs')
write_noautocmd('gS')
quit('gh')
quit_force('gH')

map('n', '<C-q>', '<C-w><C-w>', { desc = 'Switch window' })

local bduf = require('center-bduf')

map({ 'n', 'x' }, '<C-d>', bduf.cd)
map({ 'n', 'x' }, '<C-u>', bduf.cu)
map({ 'n', 'x' }, '<C-f>', bduf.cf)
map({ 'n', 'x' }, '<C-b>', bduf.cb)

-- Comfortable buffer deletion
map('n', 'gl', function()
	require('utils.common').buffer_delete()
end, { desc = 'Delete the current buffer' })

map('n', 'gL', function()
	require('utils.common').buffer_delete('others')
end, { desc = 'Delete all buffers except for the current one' })

map('n', 'gA', '<CMD>messages<CR>', { desc = 'History of messages' })

-- `ga*` keymaps
map('n', 'ga', '<Nop>')

map('n', 'gaw', function()
	vim.opt.wrap = not vim.o.wrap
	if vim.o.wrap then
		vim.notify('Wrap enabled')
	else
		vim.notify('Wrap disabled')
	end
end, { desc = 'Toggle wrap' })

map('n', 'gaS', function()
	vim.opt.spell = not vim.o.spell
	if vim.o.spell then
		vim.notify('Spellcheck enabled')
	else
		vim.notify('Spellcheck disabled')
	end
end, { desc = 'Toggle spell check' })

map('n', 'gah', function()
	vim.opt.cursorline = not vim.o.cursorline
end, { desc = 'Toggle cursorline' })

map('n', 'gaH', function()
	vim.opt.cursorcolumn = not vim.o.cursorcolumn
end, { desc = 'Toggle cursorcolumn' })

map('n', 'gaL', function()
	vim.opt.list = not vim.o.list
end, { desc = 'Toggle list' })

map('n', 'gal', function()
	vim.o.laststatus = vim.o.laststatus == 0 and 3 or 0
end, { desc = 'Toggle list' })

map('n', 'gan', function()
	vim.opt.number = not vim.o.number
end, { desc = 'Toggle number style' })

map('n', 'gaN', function()
	vim.opt.relativenumber = not vim.o.relativenumber
end, { desc = 'Toggle relative number style' })

map('n', 'gac', function()
	if vim.o.clipboard == '' then
		vim.o.clipboard = 'unnamedplus'
	else
		vim.o.clipboard = ''
	end
	vim.notify('clipboard=' .. vim.o.clipboard)
end, { desc = 'Toggle clipboard' })

local vedit_default
map('n', 'gav', function()
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

map('n', 'gar', ':<C-u>%s///g<Left><Left>', { desc = 'Start substitution' })
map('x', 'gar', ":<C-u>'<,'>s///g<Left><Left>", { desc = 'Start substitution' })

map('n', 'gad', function()
	vim.notify(vim.fn.getcwd())
end, { desc = 'Print working directory' })
map('n', 'ga-', function()
	vim.cmd('silent! cd ..')
	vim.notify(vim.fn.getcwd())
end, { desc = 'Change to upper directory' })

-- variable keybinds on states
local virtual_edit_replace = false
map({ 'n' }, 'r', function()
	return virtual_edit_replace and 'gr' or 'r'
end, { expr = true })
map({ 'n' }, 'R', function()
	return virtual_edit_replace and 'gR' or 'R'
end, { expr = true })
map('n', 'gaR', function()
	virtual_edit_replace = not virtual_edit_replace
	vim.notify('Virtual edit replace: ' .. tostring(virtual_edit_replace))
end, { desc = 'Toggle virtual edit replace' })

-- open specific files via keymaps
map('n', 'go', '<Nop>')
map('n', 'got', '<CMD>EditTodo<CR>', { desc = 'Edit todo.txt' })
map('n', 'gob', '<CMD>EditBookmarks<CR>', { desc = 'Edit bookmarks.txt' })
map('n', 'gor', '<CMD>EditReadinglist<CR>', { desc = 'Edit readinglist.txt' })
map('n', 'god', '<CMD>EditDailynote<CR>', { desc = 'Edit daily note' })
map('n', 'gos', '<CMD>EditSnippet<CR>', { desc = 'Edit snippet' })
map('n', 'goc', '<CMD>copen<CR>', { desc = 'Open QuickFix window' })

-- TODO: check if Netrw is loaded or not
map('n', 'gX', function()
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

-- <NUM><CR> to go to line. i.e. 10<CR> -> 10G
map({ 'n' }, '<CR>', function()
	return vim.v.count ~= 0 and 'G' or '<CR>'
end, { expr = true, silent = true })
