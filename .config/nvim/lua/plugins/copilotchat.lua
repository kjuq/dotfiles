-- `pip install python-dotenv requests pynvim==0.5.0 prompt-toolkit`
-- `pip install tiktoken` (optional for displaying prompt token counts)

-- authentication is automatically done when Copilot.lua is ready

local map = require("utils.lazy").generate_map("<leader>c", "CopilotChat: ")

---@type LazySpec
local spec = { "CopilotC-Nvim/CopilotChat.nvim" }
-- spec.event = "VeryLazy"
spec.build = function()
	vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
end

spec.init = function()
	vim.cmd.unlet("g:loaded_python3_provider")
	vim.cmd.unlet("g:loaded_remote_plugins")
end

spec.keys = {
	map("e", "n", "<CMD>CopilotChatExplain<CR>", "Explain yanked code"),
	map("e", "x", function()
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "x", false)
		vim.cmd("'<,'>CopilotChatVisual Explain")
	end, "Explain seleced code"),

	map("t", "n", "<CMD>CopilotChatTests<CR>", "Generate tests for yanked code"),
	map("t", "x", function()
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "x", false)
		vim.cmd("'<,'>CopilotChatVisual Tests")
	end, "Generate tests for selected code"),

	map("x", "n", ":CopilotChatInPlace<CR>", "Open In-place chat for yanked code"),
	map("x", "x", function()
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "x", false)
		vim.cmd("'<,'>CopilotChatVisual InPlace")
	end, "Open In-place chat for selected code"),
}

spec.opts = {
	show_help = "yes", -- Show help text for CopilotChatInPlace, default: yes
	disable_extra_info = "no", -- Disable extra information (e.g: system prompt) in the response.
	debug = false, -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
}

return spec
