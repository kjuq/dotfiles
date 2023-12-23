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
map({ "n", "x" }, "k", function() return vim.v.count == 0 and "gk" or "k" end, { expr = true, silent = true })
map({ "n", "x" }, "j", function() return vim.v.count == 0 and "gj" or "j" end, { expr = true, silent = true })

-- Buffer movement instead of tab's
map("n", "gt", vim.cmd.bnext, { silent = true, desc = "Go to the next buffer" })
map("n", "gT", vim.cmd.bprevious, { silent = true, desc = "Go to the previous buffer" })
map("n", "<C-Tab>", vim.cmd.bnext, { silent = true, desc = "Go to the next buffer" })
map("n", "<C-S-Tab>", vim.cmd.bprevious, { silent = true, desc = "Go to the previous buffer" })

-- Frequently used keymaps
map("n", "<leader>w", vim.cmd.write, { silent = true, desc = "Write" })
map("n", "<leader>W", function() vim.cmd("noautocmd w") end, { silent = true, desc = "Write w/o format" })
map("n", "<leader>q", vim.cmd.quit, { silent = true, desc = "Quit" })
map("n", "<leader>Q", vim.cmd.quitall, { silent = true, desc = "Quit all" })
map("n", "<C-q>", "<C-w><C-w>", { desc = "Switch window" })

-- Center cursor when searching
map("n", "n", "nzz", { silent = true, desc = 'Repeat the latest search' })
map("n", "N", "Nzz", { silent = true, desc = 'Repeat the latest search in opposite direction' })

-- Comfortable buffer deletion
map("n", "<leader>x", vim.cmd.bdelete, { silent = true, desc = "Delete the current buffer" })
map("n", "<leader>X", function() vim.cmd.bdelete { bang = true } end, {
    silent = true,
    desc = "Force delete a current buffer"
})

map("n", "gL", function() vim.cmd("messages") end, { desc = "History of messages" })
map("n", "gC", function() -- number [C]olumn (?)
    local o = vim.opt
    ---@diagnostic disable-next-line: undefined-field
    if o.number._value then
        o.number = false
        o.relativenumber = false
        ---@diagnostic disable-next-line: undefined-field
    elseif o.relativenumber._value then
        o.number = true
        o.relativenumber = false
    else
        o.number = false
        o.relativenumber = true
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

-- Diagnostics
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostics" })
map("n", "[e", vim.diagnostic.goto_prev, { desc = "Go to prev diagnostics" })
map("n", "]e", vim.diagnostic.goto_next, { desc = "Go to next diagnostics" })
map("n", "<leader>E", vim.diagnostic.setloclist, { desc = "Set diagnostics into loclist" })
