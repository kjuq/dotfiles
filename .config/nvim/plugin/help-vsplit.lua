-- https://github.com/anuvyklack/help-vsplit.nvim

local function split()
	if vim.bo.buftype == 'help' or vim.bo.filetype == 'man' then
		local origin_win = vim.fn.win_getid(vim.fn.winnr('#'))
		local origin_buf = vim.api.nvim_win_get_buf(origin_win)

		local origin_textwidth = vim.bo[origin_buf].textwidth
		if origin_textwidth == 0 then
			origin_textwidth = 80
		end

		if vim.api.nvim_win_get_width(origin_win) >= origin_textwidth + 80 then
			local help_buf = vim.fn.bufnr()

			---Origin 'bufhidden' property or the help buffer.
			local bufhidden = vim.bo.bufhidden
			vim.bo.bufhidden = 'hide'

			local old_help_win = vim.api.nvim_get_current_win()
			vim.api.nvim_set_current_win(origin_win)

			vim.api.nvim_win_close(old_help_win, false)

			vim.cmd('vsplit') -- Create new help vertical split window and make it active.
			vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), help_buf)
			vim.bo.bufhidden = bufhidden

			if not vim.o.splitright then
				vim.cmd('wincmd H')
			end
		end
	end
end

vim.api.nvim_create_autocmd({ 'WinNew' }, {
	group = vim.api.nvim_create_augroup('kjuq_helpvsplit_winnew', {}),
	callback = function()
		vim.api.nvim_create_autocmd({ 'BufEnter' }, {
			group = vim.api.nvim_create_augroup('kjuq_helpvsplit_bufenter', {}),
			callback = split,
			once = true,
		})
	end,
})
