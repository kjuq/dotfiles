local M = {}

--- @return boolean
M.has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
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
	vim.api.nvim_feedkeys(string.format('%c%c%c' .. '(' .. cmd .. ')', 0x80, 253, 83), 'x', true)
end

---@return boolean
M.is_current_file_exists = function()
	return vim.fn.filereadable(vim.fn.bufname()) == 1
end

---@return boolean
M.is_empty_buffer = function()
	return vim.fn.line('$') == 1 and vim.fn.getline(1) == ''
end

--- @param ft_pattern string|table<string>
M.quit_with_esc = function(ft_pattern)
	vim.api.nvim_create_autocmd({ 'FileType' }, {
		pattern = ft_pattern,
		group = vim.api.nvim_create_augroup('kjuq_quit_with_esc', {}),
		callback = function()
			vim.keymap.set('n', '<esc>', vim.cmd.quit, { buffer = true, silent = true })
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

---@param mode 'others'|'force'|nil
M.buffer_delete = function(mode)
	if mode == 'others' then
		for _, value in pairs(get_valid_buffers()) do
			if value ~= vim.api.nvim_get_current_buf() then
				vim.api.nvim_buf_delete(value, {})
			end
		end
	else
		local cur_bufnr = vim.api.nvim_get_current_buf()
		require('utils.common').buffer_prev()
		vim.api.nvim_buf_delete(cur_bufnr, { force = mode == 'force' })
	end
end

---@param mode string
---@param keymap string
---@return boolean
M.is_keymap_set = function(keymap, mode)
	return not (vim.fn.maparg(keymap, mode) == '')
end

---@param patterns string|string[]
M.argv_contains = function(patterns)
	patterns = type(patterns) == 'string' and { patterns } or patterns --[[@ as string[] ]]
	local argv = vim.fn.argv() --[[@ as string[] ]]
	for _, arg in pairs(argv) do
		for _, pattern in pairs(patterns) do
			if string.find(arg, pattern, 1, true) then
				return true
			end
		end
	end
	return false
end

---@param path string
---@return string?
--- returns `nil` when given `path` is `/`
local get_parent_directory = function(path)
	-- Remove trailing slash if present
	path = path:gsub('/$', '')

	-- Find the last occurrence of the slash
	local parent_path = path:match('(.*/)')

	-- Remove trailing slash if present
	if parent_path and parent_path ~= '/' then
		parent_path = parent_path:gsub('/$', '')
	end

	return parent_path
end

---@param filename string
---@param directory string
---@return boolean
local file_exists_in_directory = function(filename, directory)
	local scandir = vim.uv.fs_scandir(directory)
	if scandir then
		while true do
			local name, type = vim.uv.fs_scandir_next(scandir)
			if not name then
				break
			end
			if type == 'file' and name == filename then
				return true
			end
		end
	end
	return false
end

---@return string?
--- returns `nil` when file was not found
M.parent_directory_traversal = function(filename, path)
	if vim.fn.isdirectory(path) ~= 1 then
		error('Invalid path')
	end

	-- Remove trailing slash if present
	path = path:gsub('/$', '')

	while path do
		if file_exists_in_directory(filename, path) then
			return path .. '/' .. filename
		end
		path = get_parent_directory(path)
	end

	return nil
end

M.floatwinborder = 'single'
M.floatscrolldown = '<M-f>'
M.floatscrollup = '<M-b>'
M.highlight_duration = 200 -- ms

return M
