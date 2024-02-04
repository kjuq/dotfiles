-- quit with esc in command-line window
vim.api.nvim_create_autocmd({ "CmdwinEnter" }, { -- q:
	group = vim.api.nvim_create_augroup("user_cmdwin_esc", {}),
	callback = function()
		vim.keymap.set("n", "<Esc>", vim.cmd.quit, { buffer = true })
	end,
})

vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
	group = vim.api.nvim_create_augroup("user_cmdline_enter", {}),
	callback = function()
		_G.user_cur_relativenumber = vim.o.relativenumber
		_G.user_cur_number = vim.o.number
		vim.opt.relativenumber = false
		vim.opt.number = true
	end,
})

vim.api.nvim_create_autocmd({ "CmdlineLeave" }, {
	group = vim.api.nvim_create_augroup("user_cmdline_leave", {}),
	callback = function()
		vim.opt.relativenumber = _G.user_cur_relativenumber
		vim.opt.number = _G.user_cur_number
	end,
})

-- highlight yanked text
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
	pattern = "*",
	group = vim.api.nvim_create_augroup("user_load_colorscheme", {}),
	callback = function()
		vim.api.nvim_set_hl(0, "UserHighlightOnYank", { bg = "#c43963" }) -- color is from SagaBeacon of LspSaga
		vim.api.nvim_create_autocmd({ "TextYankPost" }, {
			group = vim.api.nvim_create_augroup("user_highlight_on_yank", {}),
			callback = function()
				require("vim.highlight").on_yank({ higroup = "UserHighlightOnYank", timeout = 125 })
			end,
		})
	end,
})

-- show indent line implemented with built-in functionality
local update_indent_line = function()
	vim.opt_local.listchars:append({ leadmultispace = "╎" .. string.rep("⋅", vim.bo.tabstop - 1) })
end
vim.api.nvim_create_autocmd({ "OptionSet" }, {
	pattern = { "listchars", "tabstop", "filetype" },
	group = vim.api.nvim_create_augroup("update_indent_line", {}),
	callback = update_indent_line,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = vim.api.nvim_create_augroup("init_indent_line", {}),
	callback = update_indent_line,
})
