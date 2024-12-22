-- Loaded by `$HOME/.local/bin_kjuq/nvimcopy`

local is_linux = vim.fn.has('linux') == 1
local is_macos = vim.fn.has('mac') == 1

---@param line string|integer
---@return boolean
local is_line_empty = function(line)
	return vim.fn.getline(line) == ''
end

---@return boolean
local is_last_line_empty = function()
	return is_line_empty('$')
end

---@type function
local yank_entire_buffer = function()
	if require('utils.common').is_empty_buffer() then
		vim.fn.setreg('+', ' ')
		return
	end
	local move_left = is_last_line_empty() and '' or 'h'
	local cmd = 'ggvG$' .. move_left .. '"+d'
	vim.cmd.normal({ cmd, bang = true }) -- yank entire buffer
end

---@type function
---@param delay number
-- OS-specific function. Linux uses i3wm and MacOS may use Hammerspoon
local hide_and_paste = function(delay)
	if is_linux then
		local cmd = string.format([[!bash -c 'i3-msg scratchpad show && sleep %s && xdotool key XF86Paste']], delay)
		vim.cmd(string.format([[silent execute "%s"]], cmd))
	elseif is_macos then
		-- TODO: Implement this
	end
end

---@type table<string, function>
local confirm = {
	n = function()
		yank_entire_buffer()
		vim.cmd.startinsert()
		hide_and_paste(0)
	end,
	i = function()
		yank_entire_buffer()
		hide_and_paste(0.3)
	end,
}

vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.wrap = false

vim.keymap.set('n', '<C-g><C-g>', confirm.n, { buffer = true })
vim.keymap.set('i', '<C-g><C-g>', confirm.i, { buffer = true })
vim.keymap.set('n', 'gh', confirm.n, { buffer = true })
vim.keymap.set('n', '<Esc>', confirm.n, { buffer = true })

require('other.specialkeys').setup()
