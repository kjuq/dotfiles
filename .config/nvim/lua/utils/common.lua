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

-- https://github.com/akinsho/bufferline.nvim/blob/99337f63f0a3c3ab9519f3d1da7618ca4f91cffe/lua/bufferline/utils/init.lua#L156
---@return integer[]
local function get_valid_buffers()
	--- @param buf_num integer
	local function is_valid(buf_num)
		if not buf_num or buf_num < 1 then
			return false
		end
		local exists = vim.api.nvim_buf_is_valid(buf_num)
		return vim.bo[buf_num].buflisted and exists
	end
	return vim.tbl_filter(is_valid, vim.api.nvim_list_bufs())
end

M.buffer_next = function()
	if vim.api.nvim_get_current_buf() ~= vim.fn.max(get_valid_buffers()) then
		vim.cmd.bnext()
	end
end

M.buffer_prev = function()
	if vim.api.nvim_get_current_buf() ~= vim.fn.min(get_valid_buffers()) then
		vim.cmd.bprev()
	end
end

---@param del_others boolean|nil
M.buffer_delete = function(del_others)
	if del_others then
		for _, value in pairs(get_valid_buffers()) do
			if value ~= vim.api.nvim_get_current_buf() then
				vim.api.nvim_buf_delete(value, {})
			end
		end
	else
		local cur_bufnr = vim.api.nvim_get_current_buf()
		require("utils.common").buffer_prev()
		vim.api.nvim_buf_delete(cur_bufnr, {})
	end
end

M.floatwinborder = "single"
M.floatscrolldown = "<C-f>"
M.floatscrollup = "<C-b>"

return M
