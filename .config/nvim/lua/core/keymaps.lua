local map = vim.keymap.set

map({ "n", "v" }, "<Space>", "<Nop>")
map("n", "ga", "<Nop>")
map("n", "go", "<Nop>")

-- Space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable Ctrl-c to allow <C-c> keymappings (e.g. <C-w><C-c>, etc
map("n", "<C-c>", "<Nop>")

-- Emacs-like cursor movement in command mode
map("c", "<C-b>", "<Left>") -- Jumps to the beginning of a line by default
map("c", "<C-f>", "<Right>") -- Opens a command-line window (q:) by default
map("c", "<C-a>", "<Home>") -- Inserts all matched candidates by default, so <C-i> is enough
map("c", "<C-d>", "<Del>") -- Lists completions by default, so <C-i> is enough
-- map("c", "<C-k>", "<c-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>") -- Digraph is important

-- recall history beginning with typed characters
map("c", "<C-p>", "<Up>")
map("c", "<C-n>", "<Down>")

map("i", "<C-g><C-k>", "<C-k>")
map("i", "<C-g><C-v>", "<C-v>")

-- Move caret on display lines
-- Comfortable line specify movement by v:count
map({ "n", "x" }, "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true })
map({ "n", "x" }, "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true })

-- Buffer movement instead of tab's
map("n", "gt", vim.cmd.bnext, { silent = true, desc = "Go to the next buffer" })
map("n", "gT", vim.cmd.bprevious, { silent = true, desc = "Go to the previous buffer" })
map("n", "<C-Tab>", vim.cmd.bnext, { silent = true, desc = "Go to the next buffer" })
map("n", "<C-S-Tab>", vim.cmd.bprevious, { silent = true, desc = "Go to the previous buffer" })

-- tab movement
map("n", "]T", vim.cmd.tabnext, { silent = true, desc = "Go to the next tab" })
map("n", "[T", vim.cmd.tabprevious, { silent = true, desc = "Go to the previous tab" })
map("n", "zT", vim.cmd.tabclose, { silent = true, desc = "Close current tab page" })

-- Quickfix
map("n", "]l", vim.cmd.cnext, { desc = "Next location on QuickFix" })
map("n", "[l", vim.cmd.cprevious, { desc = "Previous location on QuickFix" })

-- Frequently used keymaps
local write = function(key)
	map("n", key, vim.cmd.write, { silent = true, desc = "Write" })
end
local write_noautocmd = function(key)
	map("n", key, function()
		vim.cmd("noautocmd write")
	end, { silent = true, desc = "Write w/o autocmd" })
end
local quit = function(key)
	map("n", key, vim.cmd.quit, { silent = true, desc = "Quit" })
end
local quit_force = function(key)
	map("n", key, function()
		vim.cmd.quit({ bang = true })
	end, { silent = true, desc = "Force quit" })
end

write("gs")
write_noautocmd("gS")
quit("gh")
quit_force("gH")

write("<leader>w")
write_noautocmd("<leader>W")
quit("<leader>q")
quit_force("<leader>Q")

map("n", "<C-q>", "<C-w><C-w>", { desc = "Switch window" })

-- Centering cursor
map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "<C-o>", "<C-o>zz")
map("n", "<C-i>", "<C-i>zz")

local is_bottom = function()
	local linesum = vim.fn.line("$")
	local bottom = vim.fn.line("w$") -- displayed bottom line
	return bottom == linesum
end

local is_top = function()
	local top = vim.fn.line("w0") -- displayed top line
	return top == 1
end

map("n", "<C-d>", function()
	if not is_bottom() then
		return "<C-d>M"
	end
end, { expr = true })

map("n", "<C-u>", function()
	if not is_top() then
		return "<C-u>M"
	end
end, { expr = true })

map("n", "<C-f>", function()
	if not is_bottom() then
		return "<C-f>M"
	end
end, { expr = true })

map("n", "<C-b>", function()
	if not is_top() then
		return "<C-b>M"
	end
end, { expr = true })

-- Comfortable buffer deletion
map("n", "gl", function()
	require("utils.common").buffer_delete()
end, { desc = "Delete the current buffer" })

map("n", "gL", function()
	require("utils.common").buffer_delete(true)
end, { desc = "Delete all buffers except for the current one" })

map("n", "gA", "<CMD>messages<CR>", { desc = "History of messages" })

map("n", "gaw", function()
	vim.opt.wrap = not vim.o.wrap
	if vim.o.wrap then
		print("Wrap enabled")
	else
		print("Wrap disabled")
	end
end, { desc = "Toggle wrap" })

map("n", "gas", function()
	vim.opt.spell = not vim.o.spell
	if vim.o.spell then
		print("Spellcheck enabled")
	else
		print("Spellcheck disabled")
	end
end, { desc = "Toggle spell check" })

map("n", "gal", function()
	vim.opt.list = not vim.o.list
end, { desc = "Toggle list" })

map("n", "gan", function()
	vim.opt.number = not vim.o.number
end, { desc = "Toggle number style" })

map("n", "gaN", function()
	vim.opt.relativenumber = not vim.o.relativenumber
end, { desc = "Toggle relative number style" })

map("n", "gac", function()
	if vim.o.clipboard == "" then
		vim.o.clipboard = "unnamedplus"
	else
		vim.o.clipboard = ""
	end
	print("clipboard=" .. vim.o.clipboard)
end, { desc = "Toggle clipboard" })

local vedit_default
map("n", "gav", function()
	if not vedit_default then
		vedit_default = vim.o.virtualedit
	end
	if vim.o.virtualedit == vedit_default then
		vim.opt.virtualedit = "all"
	else
		vim.opt.virtualedit = vedit_default
	end
	print("virtualedit=" .. vim.o.virtualedit)
end, { desc = "Toggle virtualedit" })

map("n", "gad", "<Cmd>pwd<CR>", { desc = "Print working directory" })

map("n", "ga-", "<Cmd>cd .. | pwd<CR>", { desc = "Change to upper directory" })

-- open specific files via keymaps
map("n", "got", "<CMD>EditTodo<CR>", { desc = "Edit todo.txt" })
map("n", "gob", "<CMD>EditBookmarks<CR>", { desc = "Edit bookmarks.txt" })
map("n", "gor", "<CMD>EditReadinglist<CR>", { desc = "Edit readinglist.txt" })
map("n", "god", "<CMD>EditDailynote<CR>", { desc = "Edit daily note" })
map("n", "gos", "<CMD>EditSnippet<CR>", { desc = "Edit snippet" })

-- TODO: check if Netrw is loaded or not
map("n", "gX", function()
	vim.cmd("Explore")
end, { desc = "Open Netrw" })

local insert_date = function()
	local date = os.date("%Y-%m-%d") --[[@ as string]]
	vim.api.nvim_feedkeys(date, "n", false)
end

local insert_time = function()
	local time = os.date("%H:%M:%S") --[[@ as string]]
	vim.api.nvim_feedkeys(time, "n", false)
end

map("i", "<C-g>d", insert_date, { desc = "Insert date" })
map("i", "<C-g><C-d>", insert_date, { desc = "Insert date" })
map("i", "<C-g>t", insert_time, { desc = "Insert time" })
map("i", "<C-g><C-t>", insert_time, { desc = "Insert time" })

map("n", "<Esc>", function()
	vim.cmd.nohlsearch()
	vim.cmd.fclose({ bang = true })
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", false)
end, { silent = true })

map({ "i", "s" }, "<C-l>", function()
	local mode = vim.api.nvim_get_mode().mode
	if mode == "ix" then -- completion with <C-x>
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-l>", true, false, true), "n", false)
	else
		vim.cmd.fclose({ bang = true })
	end
end, { silent = true })

-- <NUM><CR> to go to line. i.e. 10<CR> -> 10G
map({ "n" }, "<CR>", function()
	return vim.v.count ~= 0 and "G" or "<CR>"
end, { expr = true, silent = true })
