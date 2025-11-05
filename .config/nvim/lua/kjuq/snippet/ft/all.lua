local M = {}

---@type kjuq.snippet.snippet[]
M.snippets = {
	date = function()
		return os.date('%Y-%m-%d') --[[@ as string]]
	end,
	time = function()
		return os.date('%H:%M:%S') --[[@ as string]]
	end,
}

return M
