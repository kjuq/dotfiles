vim.keymap.set('n', '<Space>cr', ':<C-u>%s///g<Left><Left>', { desc = 'Start substitution' })
vim.keymap.set('x', '<Space>cr', ":<C-u>'<,'>s///g<Left><Left>", { desc = 'Start substitution' })

vim.keymap.set('n', '<Space>cv', '`[v`]', { desc = 'Select last pasted range' })

-- TODO: dot repeat in Visual mode is not implemented yet

-- for sticky cursor, it is required to obtain and store a cursor position within
-- `operatorfunc`. But I had no idea how to achieve it.

---@param cmd string
---@return fun():string?
local function operator(cmd)
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

local sort = operator('sort')
vim.keymap.set({ 'n', 'x' }, '<Space>cs', sort, { expr = true, desc = ':sort', silent = true })
local sort_n = operator('sort n')
vim.keymap.set({ 'n', 'x' }, '<Space>cS', sort_n, { expr = true, desc = ':sort n', silent = true })

local source = operator('source')
vim.keymap.set({ 'n', 'x' }, '<Space>cx', source, { expr = true, desc = ':source', silent = true })
vim.keymap.set('n', '<Space>cxx', '<Cmd>.source<CR>', { desc = '`:source` current line' })

local rmb = require('rm-multibytes')
rmb.setup()
vim.keymap.set({ 'n', 'x' }, '<Space>cj', rmb.map, { expr = true, desc = 'Remove multibytes' })

local jpspc = require('jp-spacing')
jpspc.setup()
vim.keymap.set({ 'n', 'x' }, '<Space>c<Space>', jpspc.map, { expr = true, desc = 'Format EN and JP' })
