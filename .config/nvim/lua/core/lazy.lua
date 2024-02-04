if os.getenv("NOPLUG") then
	return
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local opts = {
	defaults = {
		lazy = true,
	},
	change_detection = {
		-- automatically check for config file changes and reload the ui
		enabled = true,
		notify = false, -- get a notification when changes are found
	},
	ui = { border = require("utils.lazy").floatwinborder },
	performance = {
		rtp = {
			disabled_plugins = { -- shorten start up time for 1 ms
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	dev = {
		path = "~/codes/_nvim_plugins",
		patterns = { "kjuq" },
		fallback = true,
	},
}

require("lazy").setup("plugins", opts) -- to load multiple dir https://zenn.dev/sisi0808/articles/36ff184554ddd6
vim.keymap.set("n", "<leader>ap", function() vim.cmd("Lazy") end, { desc = "Lazy.nvim: Manage plugins" })
