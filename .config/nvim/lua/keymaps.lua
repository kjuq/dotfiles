-- Space is leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Disable Ctrl-c to allow <C-c> keymappings (e.g. <C-w><C-c>, etc
vim.keymap.set("n", "<C-c>", "<Nop>", { silent = true })

-- Emacs-like cursor movement in command mode
vim.keymap.set("c", "<C-b>", "<Left>") -- Jumps to the beginning of a line by default
vim.keymap.set("c", "<C-f>", "<Right>") -- Opens a command-line window (q:) by default
vim.keymap.set("c", "<C-a>", "<Home>") -- Inserts all matched candidates by default, so <C-i> is enough
vim.keymap.set("c", "<C-d>", "<Del>") -- Lists completions by default, so <C-i> is enough
-- vim.keymap.set("c", "<C-k>", "<c-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>") -- Digraph is important

-- Don't update register when not intend to do so
vim.keymap.set("n", "x", "\"_x", { silent = true, desc = "Delete N characters after the cursor" })
vim.keymap.set("n", "X", "\"_X", { silent = true, desc = "Delete N characters before the cursor" })
vim.keymap.set("n", "s", "\"_s", { silent = true, desc = "Delete N characters and start insert" })
vim.keymap.set("n", "S", "\"_S", { silent = true, desc = "Delete N lines and start insert" })
vim.keymap.set("n", "c", "\"_c", { silent = true, desc = "Delete Nmove text and start insert" })
vim.keymap.set("n", "C", "\"_C", { silent = true, desc = "Delete Nmove text and start insert" })
-- vim.keymap.set("n", "d", "\"_d", { silent = true, desc = "Delete Nmove text" })
vim.keymap.set("n", "D", "\"_D", { silent = true, desc = "Delete until the end of the line" })
vim.keymap.set("x", "p", "P", { silent = true, desc = "Paste; registers are unchanged" })
vim.keymap.set("x", "P", "p", { silent = true, desc = "Paste; deleted text in unnamed register" })

-- Move caret on display lines
-- Comfortable line specify movement by v:count
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Buffer movement instead of tab's
vim.keymap.set("n", "gt", "<Cmd>bnext<CR>", { silent = true, desc = "Go to the next buffer" })
vim.keymap.set("n", "gT", "<Cmd>bprevious<CR>", { silent = true, desc = "Go to the previous buffer" })

-- Center cursor when searching
vim.keymap.set("n", "n", "nzz", {
    silent = true,
    desc = 'Repeat the latest search'
})
vim.keymap.set("n", "N", "Nzz", {
    silent = true,
    desc = 'Repeat the latest search in opposite direction'
})

-- Comfortable buffer deletion
vim.keymap.set("n", "<leader>x", vim.cmd.bdelete, {
    silent = true,
    desc = "Delete a current buffer"
})
vim.keymap.set("n", "<leader>X", function () vim.cmd.bdelete { bang = true } end, {
    silent = true,
    desc = "Delete a current buffer forcibly"
})

-- Esc can be appended functions in other places such as config files of plugins
Escs = {}

local esc = function()
    vim.cmd.nohlsearch()
    vim.cmd.fclose { bang = true }
end

Escs[#Escs + 1] = esc

Exec_Escs = function ()
    for _, e in ipairs(Escs) do
        e()
    end
end

vim.keymap.set("n", "<Esc>", Exec_Escs, { silent = true })


