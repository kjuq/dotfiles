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
-- OS-specific function. Linux uses i3wm and MacOS may use Hammerspoon
local hide_and_paste = function(delay)
	if vim.fn.has('linux') == 1 then
		local cmd = string.format([[!bash -c 'i3-msg scratchpad show && sleep %s && xdotool key shift+Insert']], delay)
		vim.cmd(string.format([[silent execute "%s"]], cmd))
	elseif vim.fn.has('mac') == 1 then
		-- TODO: Implement this
		vim.notify('MacOS is currently not supported')
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

---@param lhs string
---@param rhs string
local remap = function(lhs, rhs)
	local allmodes = { 'n', 'i', 'c', 'x', 's', 'o', 't', 'l' }
	return vim.keymap.set(allmodes, lhs, rhs, { remap = true })
end

local remapall = function()
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

local setup = function()
	vim.opt_local.number = false
	vim.opt_local.relativenumber = false
	vim.opt_local.wrap = false
	vim.opt_local.swapfile = false

	vim.keymap.set('n', '<C-g><C-g>', confirm.n, { buffer = true })
	vim.keymap.set('i', '<C-g><C-g>', confirm.i, { buffer = true })
	vim.keymap.set('n', '<Esc>', confirm.n, { buffer = true })

	vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
		group = vim.api.nvim_create_augroup('kjuq_remap_all_specialkeys', {}),
		callback = function()
			remapall()
		end,
	})
end

M = {
	setup = setup,
}

return M
