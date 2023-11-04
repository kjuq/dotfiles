local map = vim.keymap.set

-- Space is leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Disable Ctrl-c to allow <C-c> keymappings (e.g. <C-w><C-c>, etc
map("n", "<C-c>", "<Nop>", { silent = true })

-- Emacs-like cursor movement in command mode
map("c", "<C-b>", "<Left>")  -- Jumps to the beginning of a line by default
map("c", "<C-f>", "<Right>") -- Opens a command-line window (q:) by default
map("c", "<C-a>", "<Home>")  -- Inserts all matched candidates by default, so <C-i> is enough
map("c", "<C-d>", "<Del>")   -- Lists completions by default, so <C-i> is enough
-- map("c", "<C-k>", "<c-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>") -- Digraph is important

-- Don't update register when not intend to do so
map("n", "x", "\"_x", { silent = true, desc = "Delete N characters after the cursor" })
map("n", "X", "\"_X", { silent = true, desc = "Delete N characters before the cursor" })
map("n", "s", "\"_s", { silent = true, desc = "Delete N characters and start insert" })
map("n", "S", "\"_S", { silent = true, desc = "Delete N lines and start insert" })
map("n", "c", "\"_c", { silent = true, desc = "Delete Nmove text and start insert" })
map("n", "C", "\"_C", { silent = true, desc = "Delete Nmove text and start insert" })
-- map("n", "d", "\"_d", { silent = true, desc = "Delete Nmove text" })
map("n", "D", "\"_D", { silent = true, desc = "Delete until the end of the line" })
map("x", "p", "P", { silent = true, desc = "Paste; registers are unchanged" })
map("x", "P", "p", { silent = true, desc = "Paste; deleted text in unnamed register" })

-- Move caret on display lines
-- Comfortable line specify movement by v:count
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Buffer movement instead of tab's
map("n", "gt", "<Cmd>bnext<CR>", { silent = true, desc = "Go to the next buffer" })
map("n", "gT", "<Cmd>bprevious<CR>", { silent = true, desc = "Go to the previous buffer" })
map("n", "<C-Tab>", "<Cmd>bnext<CR>", { silent = true, desc = "Go to the next buffer" })
map("n", "<C-S-Tab>", "<Cmd>bprevious<CR>", { silent = true, desc = "Go to the previous buffer" })
map("n", "<leader>w", function() vim.cmd("w") end, { silent = true, desc = "Write the whole buffer to the current file" })

-- Center cursor when searching
map("n", "n", "nzz", { silent = true, desc = 'Repeat the latest search' })
map("n", "N", "Nzz", { silent = true, desc = 'Repeat the latest search in opposite direction' })

-- Comfortable buffer deletion
map("n", "<leader>x", vim.cmd.bdelete, { silent = true, desc = "Delete a current buffer" })
map("n", "<leader>X", function() vim.cmd.bdelete { bang = true } end, {
    silent = true,
    desc = "Force delete a current buffer"
})

-- Esc can be appended functions in other places such as config files of plugins
Escs = {}

local esc = function()
    vim.cmd.nohlsearch()
    vim.cmd.fclose { bang = true }
end

Escs[#Escs + 1] = esc

Exec_Escs = function()
    for _, e in ipairs(Escs) do
        e()
    end
end

map("n", "<Esc>", Exec_Escs, { silent = true })
