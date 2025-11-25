local M = {}

-- TODO: dot repeat in Visual mode is not implemented yet

-- for sticky cursor, it is required to obtain and store a cursor position within
-- `operatorfunc`. But I had no idea how to achieve it.

---@param cmd string
---@return fun():string?
function M.operator(cmd)
	local name = cmd:gsub(' ', '_')
	local opfunc = string.format('kjuq_%s', name)
	_G[string.format('kjuq_%s', name)] = function()
		vim.cmd(string.format([[ '[,'] %s ]], cmd))
	end
	return function()
		local mode = vim.api.nvim_get_mode().mode:sub(1, 1)
		if not vim.tbl_contains({ 'n', 'v', 'V' }, mode) then
			vim.notify('Unexpected mode detected', vim.log.levels.ERROR)
			return nil
		end
		if mode == 'n' then
			vim.o.operatorfunc = string.format('v:lua._G.%s', opfunc)
			return 'g@'
		elseif mode == 'v' or mode == 'V' then
			vim.o.operatorfunc = nil
			return string.format(':%s<CR>', cmd)
		end
	end
end

local function setup()
	local sort = M.operator('sort')
	vim.keymap.set({ 'n', 'x' }, '<Space>cs', sort, { expr = true, desc = ':sort', silent = true })
	local sort_n = M.operator('sort n')
	vim.keymap.set({ 'n', 'x' }, '<Space>cS', sort_n, { expr = true, desc = ':sort n', silent = true })
	local source = M.operator('source')
	vim.keymap.set({ 'n', 'x' }, '<Space>cx', source, { expr = true, desc = ':source', silent = true })
	-- TODO: Add oneline option
	vim.keymap.set('n', '<Space>cxx', '<Cmd>.source<CR>', { desc = '`:source` current line' })
end

setup()

return M
