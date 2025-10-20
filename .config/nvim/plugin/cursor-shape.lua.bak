vim.api.nvim_create_autocmd({ 'VimLeave' }, {
	group = vim.api.nvim_create_augroup('kjuq_restore_cursor_shape', {}),
	callback = function()
		vim.opt.guicursor = ''
		-- "\x1b[ q" is an ESC sequence that sets the cursor style in the terminal.
		-- Here, it returns the cursor to the normal block shape.
		-- Other examples include:
		-- "\x1b[1 q" for a block.
		-- "\x1b[3 q" for a underline.
		-- "\x1b[5 q" for a thin vertical line.
		vim.api.nvim_chan_send(vim.v.stderr, '\x1b[ q')
	end,
})
