local map = vim.keymap.set

-- Space is leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Disable Ctrl-c to allow <C-c> keymappings (e.g. <C-w><C-c>, etc
map("n", "<C-c>", "<Nop>", { silent = true })

-- Emacs-like cursor movement in command mode
map("c", "<C-b>", "<Left>")  -- Jumps to the beginning of a line by default
map("c", "<C-f>", "<Right>") -- Opens a command-line window (q:) by default
map("c", "<C-a>", "<Home>")  -- Inserts all matched candidates by default, so <C-i> is enough
map("c", "<C-d>", "<Del>")   -- Lists completions by default, so <C-i> is enough
-- map("c", "<C-k>", "<c-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>") -- Digraph is important

-- recall history beginning with typed characters
map("c", "<C-p>", "<Up>")
map("c", "<C-n>", "<Down>")

-- Don't update register when not intend to do so

map("n", "x", function()
    return vim.v.count == 0 and "\"_x" or "x"
end, { expr = true, silent = true, desc = "Delete N characters after the cursor" })

map("n", "X", function()
    return vim.v.count == 0 and "\"_X" or "X"
end, { expr = true, silent = true, desc = "Delete N characters before the cursor" })

map("n", "s", function()
    return vim.v.count == 0 and "\"_s" or "s"
end, { expr = true, silent = true, desc = "Delete N characters and start insert" })

-- map("n", "S", '"_S', { silent = true, desc = "Delete N lines and start insert" })
-- map("n", "c", '"_c', { silent = true, desc = "Delete Nmove text and start insert" })
-- map("n", "C", '"_C', { silent = true, desc = "Delete Nmove text and start insert" })
-- map("n", "d", '"_d', { silent = true, desc = "Delete Nmove text" })
-- map("n", "D", '"_D', { silent = true, desc = "Delete until the end of the line" })
map("x", "p", "P", { silent = true, desc = "Paste; registers are unchanged" })
map("x", "P", "p", { silent = true, desc = "Paste; deleted text in unnamed register" })

-- Move caret on display lines
-- Comfortable line specify movement by v:count
map({ "n", "x" }, "k", function() return vim.v.count == 0 and "gk" or "k" end, { expr = true, silent = true })
map({ "n", "x" }, "j", function() return vim.v.count == 0 and "gj" or "j" end, { expr = true, silent = true })

-- Buffer movement instead of tab's
map("n", "gt", vim.cmd.bnext, { silent = true, desc = "Go to the next buffer" })
map("n", "gT", vim.cmd.bprevious, { silent = true, desc = "Go to the previous buffer" })
map("n", "<C-Tab>", vim.cmd.bnext, { silent = true, desc = "Go to the next buffer" })
map("n", "<C-S-Tab>", vim.cmd.bprevious, { silent = true, desc = "Go to the previous buffer" })

-- Quickfix
map("n", "]l", vim.cmd.cnext, { desc = "Next location on QuickFix" })
map("n", "[l", vim.cmd.cprevious, { desc = "Previous location on QuickFix" })

-- Frequently used keymaps
local write = function(key)
    map("n", key, vim.cmd.write, { silent = true, desc = "Write" })
end
local write_noautocmd = function(key)
    map("n", key, function() vim.cmd("noautocmd w") end, { silent = true, desc = "Write w/o autocmd" })
end
local quit = function(key)
    map("n", key, vim.cmd.quit, { silent = true, desc = "Quit" })
end
local quit_all = function(key)
    map("n", key, vim.cmd.quitall, { silent = true, desc = "Quit all" })
end
write("gs")
write("<leader>w")
write_noautocmd("gS")
write_noautocmd("<leader>W")
quit("gh")
quit("<leader>q")
quit_all("gH")
quit_all("<leader>Q")

map("n", "<C-q>", "<C-w><C-w>", { desc = "Switch window" })

-- Center cursor when searching
map("n", "n", "nzz", { silent = true, desc = "Repeat the latest search" })
map("n", "N", "Nzz", { silent = true, desc = "Repeat the latest search in opposite direction" })

-- Comfortable buffer deletion
local bdelete = function(key)
    map("n", key, vim.cmd.bdelete, { silent = true, desc = "Delete the current buffer" })
end
local bdelete_force = function(key)
    map("n", key, function() vim.cmd.bdelete { bang = true } end, {
        silent = true,
        desc = "Force delete a current buffer"
    })
end
bdelete("gl")
bdelete("<leader>x")
bdelete_force("gL")
bdelete_force("<leader>X")

map("n", "gW", function() vim.opt.wrap = not vim.o.wrap end, { desc = "Toggle wrap" })
map("n", "gA", function() vim.cmd("messages") end, { desc = "History of messages" })
map("n", "gC", function() -- number [C]olumn (?)
    local opt = vim.opt
    local o = vim.o
    if o.number then
        opt.number = false
        opt.relativenumber = false
    elseif o.relativenumber then
        opt.number = true
        opt.relativenumber = false
    else
        opt.number = false
        opt.relativenumber = true
    end
end, { desc = "Toggle number style" })

map("n", "<Esc>", function()
    vim.cmd.nohlsearch()
    vim.cmd.fclose { bang = true }
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", false)
end, { silent = true })

map({ "i", "s" }, "<C-l>", function()
    local mode = vim.api.nvim_get_mode().mode
    if mode == "ix" then -- completion with <C-x>
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-l>", true, false, true), "n", false)
    else
        vim.cmd.fclose { bang = true }
    end
end, { silent = true })

-- <NUM><CR> to go to line. i.e. 10<CR> -> 10G
map({ "n" }, "<CR>", function() return vim.v.count ~= 0 and "G" or "<CR>" end, { expr = true, silent = true })
