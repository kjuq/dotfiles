vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set('n', '<c-h>', '<c-w>h')

vim.keymap.set("c", "<C-b>", "<Left>")
vim.keymap.set("c", "<C-f>", "<Right>")
--vim.keymap.set("c", "<C-n>", "<Down>")
--vim.keymap.set("c", "<C-p>", "<Up>")
vim.keymap.set("c", "<C-a>", "<Home>")
--vim.keymap.set("c", "<C-e>", "<End>")
vim.keymap.set("c", "<C-d>", "<Del>")
--vim.keymap.set("c", "<C-k>", "<c-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>")

vim.keymap.set("n", "x", "\"_x")

-- move caret on display lines
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("v", "j", "gj")
vim.keymap.set("v", "k", "gk")

vim.keymap.set("n", "gt", "<Cmd>bnext<CR>")
vim.keymap.set("n", "gT", "<Cmd>bprevious<CR>")

vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

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


