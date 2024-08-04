-- loaded by `$LOCAL_BIN_PATH/nvimcopy`

vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.wrap = false

vim.keymap.set({ 'n', 'i' }, '<C-g><C-g>', function()
	vim.cmd.normal([[ggvG$h"+di]]) -- yank entire buffer
	vim.cmd([[silent exec "!i3-msg scratchpad show"]])
end, { buffer = true })
