local hide_by_default = true

---@type LazySpec
local spec = {
	"petertriho/nvim-scrollbar",
	keys = {
		{ "<leader>as", mode = "n", function() require("scrollbar.utils").toggle() end, desc = "Scrollbar: Toggle" },
	},
	event = hide_by_default and {} or { "WinScrolled" },
	config = function()
		require("scrollbar").setup({
			excluded_filetypes = {
				"ccc-ui",
				"cmp_docs",
				"cmp_menu",
				"dap-float",
				"noice",
				"prompt",
				"TelescopePrompt",
				"saga_codeaction",
				"sagarename",
			},
		})

		require("scrollbar.handlers.search").setup({
			override_lens = function() end,
		})

		require("gitsigns").setup() -- in case that gitsigns.lua doesn't exist
		require("scrollbar.handlers.gitsigns").setup()

		if hide_by_default then
			require("scrollbar.utils").hide()
		end
	end,
	dependencies = {
		"kevinhwang91/nvim-hlslens",
		"lewis6991/gitsigns.nvim",
	},
}

return spec
