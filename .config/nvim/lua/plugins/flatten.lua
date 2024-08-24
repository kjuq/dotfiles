---@type LazySpec
local spec = { 'willothy/flatten.nvim' }
spec.event = { 'BufWinEnter' }

spec.lazy = os.getenv('NVIM') == nil

spec.opts = function()
	local saved_terminal
	local number_bak = vim.o.number
	local relativenumber_bak = vim.o.relativenumber
	local list_bak = vim.o.list
	return {
		callbacks = {
			pre_open = function()
				local term = require('toggleterm.terminal')
				local termid = term.get_focused_id()
				saved_terminal = term.get(termid)
			end,
			post_open = function(bufnr, _, filetype)
				vim.o.number = number_bak
				vim.o.relativenumber = relativenumber_bak
				vim.o.list = list_bak
				if saved_terminal then
					saved_terminal:close()
				end

				vim.api.nvim_set_current_buf(bufnr)

				-- If the file is a git commit, create one-shot autocmd to delete its buffer on write
				-- If you just want the toggleable terminal integration, ignore this bit
				if filetype == 'gitcommit' or filetype == 'gitrebase' then
					vim.api.nvim_create_autocmd('BufWritePost', {
						buffer = bufnr,
						once = true,
						callback = vim.schedule_wrap(function()
							vim.api.nvim_buf_delete(bufnr, {})
						end),
					})
				end
			end,
		},
	}
end

return spec
