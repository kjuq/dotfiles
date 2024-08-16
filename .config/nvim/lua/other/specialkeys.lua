local allmodes = { 'n', 'i', 'c', 'x', 's', 'o', 't', 'l' }

---@param lhs string
---@param rhs string
local remap = function(lhs, rhs)
	return vim.keymap.set(allmodes, lhs, rhs, { remap = true })
end

local M = {}

M.remapall = function()
	remap('<Up>', '<C-p>')
	remap('<Down>', '<C-n>')
	remap('<Left>', '<C-b>')
	remap('<Right>', '<C-f>')
	remap('<BS>', '<C-h>')
	remap('<Del>', '<C-d>')
	remap('<Tab>', '<C-i>')
	remap('<HOME>', '<C-a>')
	remap('<END>', '<C-e>')
	remap('<CR>', '<C-m>')

	remap('<M-Up>', '<M-C-p>')
	remap('<M-Down>', '<M-C-n>')
	remap('<M-Left>', '<M-C-b>')
	remap('<M-Right>', '<M-C-f>')
	remap('<M-BS>', '<M-C-h>')
	remap('<M-Del>', '<M-C-d>')
	remap('<M-Tab>', '<M-C-i>')
	remap('<M-HOME>', '<M-C-a>')
	remap('<M-END>', '<M-C-e>')
	remap('<M-CR>', '<M-C-m>')

	-- MacOS
	remap('<M-Right>', '<M-f>')
	remap('<M-Left>', '<M-b>')
	remap('<M-BS>', '<C-w>')

	-- Linux
	remap('<C-Right>', '<M-f>')
	remap('<C-Left>', '<M-b>')
	remap('<C-BS>', '<C-w>') -- may not work because tty doesn't recognize C-Backspace

	-- Both
	remap('<C-M-Right>', '<C-M-f>')
	remap('<C-M-Left>', '<C-M-b>')
	remap('<C-M-BS>', '<M-C-w>') -- available only on ORS layer
end

M.setup = function()
	vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
		group = vim.api.nvim_create_augroup('user_remap_all_specialkeys', {}),
		callback = function()
			M.remapall()
		end,
	})
end

return M
