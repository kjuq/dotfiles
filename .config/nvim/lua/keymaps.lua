vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable Ctrl-c to allow <C-c> keymappings (e.g. <C-w><C-c>, etc
vim.keymap.set("n", "<C-c>", "<Nop>")

-- Emacs-like cursor movement in command mode
vim.keymap.set("c", "<C-b>", "<Left>") -- Jumps to the beginning of a line by default
vim.keymap.set("c", "<C-f>", "<Right>") -- Opens a command-line window (q:) by default
vim.keymap.set("c", "<C-a>", "<Home>") -- Inserts all matched candidates by default, so <C-i> is enough
vim.keymap.set("c", "<C-d>", "<Del>") -- Lists completions by default, so <C-i> is enough
-- vim.keymap.set("c", "<C-k>", "<c-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>") -- Digraph is important

-- Don't update register when deleting letters by "x"
vim.keymap.set("n", "x", "\"_x")

-- Move caret on display lines
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("v", "j", "gj")
vim.keymap.set("v", "k", "gk")

-- Buffer movement instead of tab's
vim.keymap.set("n", "gt", "<Cmd>bnext<CR>")
vim.keymap.set("n", "gT", "<Cmd>bprevious<CR>")

-- Center cursor when searching
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- Comfortable buffer deletion
vim.keymap.set("n", "<leader>x", vim.cmd.bdelete)
vim.keymap.set("n", "<leader>X", function () vim.cmd.bdelete { bang = true } end)

Escs = {}

local esc = function()
    vim.api.nvim_command("nohlsearch")
end

Escs[#Escs + 1] = esc

Exec_Escs = function ()
    for _, e in ipairs(Escs) do
        e()
    end
end

vim.keymap.set("n", "<Esc>", Exec_Escs, { silent = true })


