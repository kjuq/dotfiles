---@type LazySpec
local spec = { "willothy/flatten.nvim" }
spec.event = { "BufWinEnter" }

spec.init = function()
	_G._user_flatten_number = vim.o.number
	_G._user_flatten_relativenumber = vim.o.relativenumber
	_G._user_flatten_list = vim.o.list
end

spec.opts = function()
	local saved_terminal
	return {
		callbacks = {
			pre_open = function()
				local term = require("toggleterm.terminal")
				local termid = term.get_focused_id()
				saved_terminal = term.get(termid)
			end,
			post_open = function(bufnr, _, filetype)
				vim.opt.number = _G._user_flatten_number
				vim.opt.relativenumber = _G._user_flatten_relativenumber
				vim.opt.list = _G._user_flatten_list

				if saved_terminal then
					saved_terminal:close()
				end

				vim.api.nvim_set_current_buf(bufnr)

				-- If the file is a git commit, create one-shot autocmd to delete its buffer on write
				-- If you just want the toggleable terminal integration, ignore this bit
				if filetype == "gitcommit" or filetype == "gitrebase" then
					vim.api.nvim_create_autocmd("BufWritePost", {
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

spec._user_load_library = true

return spec
