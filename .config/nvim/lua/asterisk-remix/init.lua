local M = {}

local is_focusing_search_word = function() end

M.keys = {
	['*'] = function()
		if vim.v.hlsearch == 1 then
			vim.cmd.normal({ 'n', bang = true })
			return
		end
		vim.cmd.normal({ '*N', bang = true })
	end,
}

return M
