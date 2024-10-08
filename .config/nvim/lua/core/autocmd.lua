local group = vim.api.nvim_create_augroup('kjuq_core_augroup', {})

-- quit with esc in command-line window
vim.api.nvim_create_autocmd({ 'CmdwinEnter' }, { -- q:
	group = group,
	callback = function()
		vim.keymap.set('n', '<Esc>', vim.cmd.quit, { buffer = true })
	end,
})

---@type boolean
local relativenumber_bak
---@type boolean
local number_bak
---@type boolean
local cursorline_bak

vim.api.nvim_create_autocmd({ 'CmdlineEnter' }, {
	group = group,
	callback = function()
		relativenumber_bak = vim.o.relativenumber
		number_bak = vim.o.number
		cursorline_bak = vim.o.cursorline
		vim.opt.relativenumber = false
		vim.opt.number = true
		vim.opt.cursorline = true
	end,
})

vim.api.nvim_create_autocmd({ 'CmdlineLeave' }, {
	group = group,
	callback = function()
		vim.opt.relativenumber = relativenumber_bak
		vim.opt.number = number_bak
		vim.o.cursorline = cursorline_bak
	end,
})

-- highlight yanked text
vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
	pattern = '*',
	group = group,
	callback = function()
		vim.api.nvim_set_hl(0, 'kjuq_highlight_on_yank', { bg = '#c43963' }) -- color is from SagaBeacon of LspSaga
		vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
			group = vim.api.nvim_create_augroup('kjuq_highlight_on_yank', {}),
			callback = function()
				local timeout = require('utils.common').highlight_duration
				require('vim.highlight').on_yank({ higroup = 'kjuq_highlight_on_yank', timeout = timeout })
			end,
		})
	end,
})

vim.api.nvim_create_autocmd({ 'TextYankPost', 'FocusLost', 'CmdlineLeave' }, {
	group = group,
	callback = function()
		vim.cmd.wshada()
	end,
})

vim.api.nvim_create_autocmd({ 'FocusGained', 'CmdLineEnter' }, {
	group = group,
	callback = function()
		vim.cmd.rshada()
	end,
})

vim.api.nvim_create_autocmd({ 'TermRequest' }, {
	callback = function(_)
		if string.sub(vim.v.termrequest, 1, 4) == '\x1b]7;' then
			local dir = string.gsub(vim.v.termrequest, '\x1b]7;file://[^/]*', '')
			if vim.fn.isdirectory(dir) == 0 then
				vim.notify('invalid dir: ' .. dir)
				return
			else
				vim.notify('cd ' .. dir)
				vim.cmd.cd(dir)
			end
		end
	end,
	desc = 'Handles OSC 7 dir change requests',
	group = group,
})

-- -- highlight cursorline when moving is finished
-- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
-- 	group = group,
-- 	callback = function()
-- 		vim.opt.cursorline = true
-- 		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
-- 			group = vim.api.nvim_create_augroup("kjuq_unhighlight_cur_line", {}),
-- 			callback = function()
-- 				vim.opt.cursorline = false
-- 			end,
-- 			once = true,
-- 		})
-- 	end,
-- })

-- show indent line implemented with built-in functionality
local update_indent_line = function()
	vim.opt_local.listchars:append({ leadmultispace = '╎' .. string.rep('⋅', vim.bo.tabstop - 1) })
end
vim.api.nvim_create_autocmd({ 'OptionSet' }, {
	pattern = { 'listchars', 'tabstop', 'filetype' },
	group = vim.api.nvim_create_augroup('kjuq_update_indent_line', {}),
	callback = update_indent_line,
})
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
	group = vim.api.nvim_create_augroup('kjuq_init_indent_line', {}),
	callback = update_indent_line,
})
