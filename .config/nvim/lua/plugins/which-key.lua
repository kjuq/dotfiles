local map = require("utils.lazy").generate_map("<leader>a", "Which-key: ")

local active = false

local enable = function()
	vim.o.timeout = true
	vim.o.timeoutlen = 700
	active = true
end

local disable = function()
	vim.o.timeout = false
	active = false
end

local toggle = function()
	if active then
		print("Which-key is inactive")
		disable()
	else
		print("Which-key is active")
		enable()
	end
end

---@type LazySpec
local spec = { "folke/which-key.nvim" }
spec.event = require("utils.lazy").verylazy

spec.enabled = os.getenv("SSH_TTY") == nil -- which-key breaks osc52

spec.keys = {
	map("w", "n", toggle, "Toggle"),
	map("W", "n", function()
		vim.cmd("WhichKey")
	end, "Show all keymaps"),
}

spec.opts = function()
	enable()

	require("which-key").register({
		["gcd"] = { name = "Annotation", _ = "which_key_ignore" },
		["go"] = { name = "Edit specific file", _ = "which_key_ignore" },
		["<leader>a"] = { name = "Additional", _ = "which_key_ignore" },
		["<leader>b"] = { name = "Bufferline", _ = "which_key_ignore" },
		["<leader>c"] = { name = "ChatGPT", _ = "which_key_ignore" },
		["<leader>d"] = { name = "Doc string", _ = "which_key_ignore" },
		["<leader>D"] = { name = "DAP", _ = "which_key_ignore" },
		["<leader>f"] = { name = "Find", _ = "which_key_ignore" },
		["<leader>g"] = { name = "Git", _ = "which_key_ignore" },
		["<leader>r"] = { name = "Resume", _ = "which_key_ignore" },
		["<leader>s"] = { name = "Substitute", _ = "which_key_ignore" },
		["<leader>t"] = { name = "Trouble", _ = "which_key_ignore" },
		["<M-w>"] = { name = "Workspace", _ = "which_key_ignore" },
	})

	return {
		window = {
			border = "single",
		},
		layout = {
			width = { max = 80 }, -- min and max width of the columns
			spacing = 3, -- spacing between columns
			align = "left", -- align columns left, center or right
		},
	}
end

return spec
