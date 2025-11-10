local M = {}

---@type kjuq.snippet.snippet[]
M.snippets = {
	date = function()
		return assert(os.date('%Y-%m-%d'))
	end,
	time = function()
		return assert(os.date('%H:%M'))
	end,
	timem = function()
		return assert(os.date('%H:%M:%S'))
	end,
}

return M
