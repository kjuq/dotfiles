---@type LazySpec
local spec = { "folke/persistence.nvim" }
spec.event = require("utils.lazy").verylazy

local map = require("utils.lazy").generate_map("<leader>r", "Persistence: ")
spec.keys = {
	map("s", "n", function()
		require("persistence").load()
	end, "Restore session for the current dir"),
	map("l", "n", function()
		require("persistence").load({ last = true })
	end, "Restore the last session"),
	map("p", "n", function()
		require("persistence").select()
	end, "Pick a session to load"),
	map("d", "n", function()
		require("persistence").stop()
	end, "Stop saving session on exit"),
}

spec.opts = {}

spec.config = function(_, opts)
	local dir_bak
	vim.api.nvim_create_autocmd({ "User" }, {
		pattern = "PersistenceSavePre",
		group = vim.api.nvim_create_augroup("user_persistence_save_pre", {}),
		callback = function()
			dir_bak = vim.fn.getcwd()
			if _G._user_init_cwd then
				vim.fn.chdir(_G._user_init_cwd)
			end
		end,
	})
	vim.api.nvim_create_autocmd({ "User" }, {
		pattern = "PersistenceSavePost",
		group = vim.api.nvim_create_augroup("user_persistence_save_post", {}),
		callback = function()
			vim.fn.chdir(dir_bak)
		end,
	})

	require("persistence").setup(opts)

	if #vim.fn.argv() == 0 then -- if neovim was launched without any files as args
		local delay_ms = 0
		vim.defer_fn(function()
			require("persistence").load()
		end, delay_ms)
	end
end

return spec
