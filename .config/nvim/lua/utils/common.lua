local M = {}

--- @return boolean
M.has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

--- @return boolean
M.has_floating_win = function()
	for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.api.nvim_win_get_config(winid).zindex then
			return true
		end
	end
	return false
end

---@param cmd string
M.feed_plug = function(cmd)
	-- https://github.com/neovim/neovim/blob/b535575acdb037c35a9b688bc2d8adc2f3dece8d/src/nvim/keymap.h#L225
	-- https://www.reddit.com/r/neovim/comments/kup1g0/comment/givujwd
	vim.fn.feedkeys(string.format("%c%c%c" .. "(" .. cmd .. ")", 0x80, 253, 83))
end

---@return boolean
M.is_current_file_exists = function()
	return vim.fn.filereadable(vim.fn.bufname()) == 1
end

---@return boolean
M.is_empty_buffer = function()
	return vim.fn.line("$") == 1 and vim.fn.getline(1) == ""
end

--- @param ft_pattern string|table<string>
M.quit_with_esc = function(ft_pattern)
	vim.api.nvim_create_autocmd({ "FileType" }, {
		pattern = ft_pattern,
		group = vim.api.nvim_create_augroup("user_quit_with_esc", {}),
		callback = function()
			vim.keymap.set("n", "<esc>", vim.cmd.quit, { buffer = true, silent = true })
		end,
	})
end

M.floatwinborder = "single"
M.floatscrolldown = "<C-f>"
M.floatscrollup = "<C-b>"

return M
