local group = vim.api.nvim_create_augroup("user_core_augroup", {})

-- quit with esc in command-line window
vim.api.nvim_create_autocmd({ "CmdwinEnter" }, { -- q:
	group = group,
	callback = function()
		vim.keymap.set("n", "<Esc>", vim.cmd.quit, { buffer = true })
	end,
})

vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
	group = group,
	callback = function()
		_G.user_cur_relativenumber = vim.o.relativenumber
		_G.user_cur_number = vim.o.number
		vim.opt.relativenumber = false
		vim.opt.number = true
	end,
})

vim.api.nvim_create_autocmd({ "CmdlineLeave" }, {
	group = group,
	callback = function()
		vim.opt.relativenumber = _G.user_cur_relativenumber
		vim.opt.number = _G.user_cur_number
	end,
})

-- highlight yanked text
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
	pattern = "*",
	group = group,
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

vim.api.nvim_create_autocmd({ "TermRequest" }, {
	callback = function(ev)
		if string.sub(vim.v.termrequest, 1, 4) == "\x1b]7;" then
			local dir = string.gsub(vim.v.termrequest, "\x1b]7;file://[^/]*", "")
			if vim.fn.isdirectory(dir) == 0 then
				vim.notify("invalid dir: " .. dir)
				return
			else
				vim.notify("cd " .. dir)
				vim.cmd.cd(dir)
			end
		end
	end,
	desc = "Handles OSC 7 dir change requests",
	group = group,
})

-- -- highlight cursorline when moving is finished
-- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
-- 	group = group,
-- 	callback = function()
-- 		vim.opt.cursorline = true
-- 		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
-- 			group = vim.api.nvim_create_augroup("user_unhighlight_cur_line", {}),
-- 			callback = function()
-- 				vim.opt.cursorline = false
-- 			end,
-- 			once = true,
-- 		})
-- 	end,
-- })

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
