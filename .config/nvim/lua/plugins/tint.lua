---@type LazySpec
local spec = { "levouh/tint.nvim" }
-- spec.event = { "FocusLost", "WinLeave" } -- buggy on first launch of telescope
spec.event = require("utils.lazy").verylazy

spec.opts = {
	tint = -75,
	highlight_ignore_patterns = { "WinSeparator" },
}

spec.config = function(_, opts)
	local tint = require("tint")
	tint.setup(opts)

	vim.api.nvim_create_autocmd("FocusLost", {
		group = vim.api.nvim_create_augroup("_user_tint_focus_lost", {}),
		callback = function()
			-- TODO: tint all windows
			tint.tint(vim.api.nvim_get_current_win())
		end,
	})

	vim.api.nvim_create_autocmd("FocusGained", {
		group = vim.api.nvim_create_augroup("_user_tint_focus_gained", {}),
		callback = function()
			tint.untint(vim.api.nvim_get_current_win())
		end,
	})
end

return spec
