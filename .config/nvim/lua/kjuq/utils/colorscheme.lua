local M = {}

M.override = {
	dark = function()
		vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'NONE', ctermbg = 'NONE' })
		vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'NONE', ctermbg = 'NONE' })
		vim.api.nvim_set_hl(0, 'WinSeparator', { fg = 'DarkGray' })
		vim.api.nvim_set_hl(0, 'VertSplit', { link = 'WinSeparator' })
		vim.api.nvim_set_hl(0, 'Cursor', { bg = 'LightGreen' })
	end,
	light = function()
		vim.api.nvim_set_hl(0, 'Cursor', { bg = 'Black' })
	end,
}

---@param enable boolean?
local function is_transparent(enable)
	if enable == nil then
		return true
	end
	return enable
end

---@param enable boolean?
function M.make_transparent(enable)
	if not is_transparent(enable) then
		return
	end
	vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE', ctermbg = 'NONE' }) -- background
end

return M
