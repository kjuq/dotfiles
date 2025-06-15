local M = {}

function M.delete_trailing_empty_lines()
	local bufnr = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

	local num_empty_lines_to_delete = 0

	for i = #lines, 1, -1 do
		local line = lines[i]
		if line:match('^%s*$') then
			num_empty_lines_to_delete = num_empty_lines_to_delete + 1
		else
			break
		end
	end

	if num_empty_lines_to_delete == 0 then
		return
	end

	local start_index = #lines - num_empty_lines_to_delete
	local end_index = #lines

	vim.api.nvim_buf_set_lines(bufnr, start_index, end_index, false, {})
end

return M
