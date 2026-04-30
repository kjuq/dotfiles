local M = {}

-- Usage: `nvim -c 'lua require("kjuq.asime").setup()'`

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
	if vim.fn.line('$') == 1 and vim.fn.getline(1) == '' then
		vim.fn.setreg('+', ' ')
		vim.fn.setreg('*', ' ')
		return
	end
	local move_left = is_last_line_empty() and '' or 'h'
	local cmd = 'ggvG$' .. move_left .. '"+d'
	vim.cmd.normal({ cmd, bang = true }) -- yank entire buffer
	vim.fn.setreg('*', vim.fn.getreg('+'))
end

---@type function
---@param delay number
-- OS-specific function. Linux uses i3wm and MacOS may use Aerospace
local hide_and_paste = function(delay)
	if vim.fn.has('linux') == 1 then
		local cmd = string.format([[!bash -c 'i3-msg scratchpad show && sleep %s && xdotool key shift+Insert']], delay)
		vim.cmd(string.format([[silent execute "%s"]], cmd))
	elseif vim.fn.has('mac') == 1 then
		local cmd = string.format(
			[[!bash -c 'aerospace-scratchpad show ".+" --filter window-id=$(cat /tmp/kjuq_aerospace_scratchpad_winid) && sleep %s && osascript -e \'tell application "System Events" to keystroke "v" using command down\'']],
			delay
		)
		-- vim.cmd(string.format([[silent execute "%s"]], cmd))
		vim.cmd(cmd)
		-- local hidewin = [[!hs -c 'hs.eventtap.keyStroke({"cmd"}, "h")']]
		-- vim.cmd(hidewin)
		-- local paste = [[!hs -c 'hs.eventtap.keyStroke({"cmd"}, "v")']]
		-- vim.cmd(paste)
	end
end

---@type table<string, function>
local confirm = {
	n = function()
		yank_entire_buffer()
		vim.cmd.startinsert()
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-Space>', true, false, true), 'm', false) -- Enables SKK
		hide_and_paste(0)
	end,
	i = function()
		yank_entire_buffer()
		hide_and_paste(0.3)
	end,
}

local setup = function()
	vim.opt_local.number = false
	vim.opt_local.relativenumber = false
	vim.opt_local.wrap = false
	vim.opt_local.swapfile = false

	vim.keymap.set('n', '<C-g><C-g>', confirm.n, { buffer = true })
	vim.keymap.set('i', '<C-g><C-g>', confirm.i, { buffer = true })
	vim.keymap.set('n', '<Esc>', confirm.n, { buffer = true })
end

M = {
	setup = setup,
}

return M
