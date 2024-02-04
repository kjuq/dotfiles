local map = require("utils.lazy").generate_map("<leader>b", "Bufferline: ")

---@type LazySpec
local spec = {
	"akinsho/bufferline.nvim",
	version = "*",
	event = { "BufNew", "WinScrolled" },
	keys = {
		map("b", "n", function() vim.cmd("BufferLinePick") end, "Pick"),
		map("p", "n", function() vim.cmd("BufferLineTogglePin") end, "Pin"),
		map("h", "n", function() vim.cmd("BufferLineMovePrev") end, "Move left"),
		map("l", "n", function() vim.cmd("BufferLineMoveNext") end, "Move right"),
		map("u", "n", function() vim.cmd("BufferLineCloseLeft") end, "Close left"),
		map("k", "n", function() vim.cmd("BufferLineCloseRight") end, "Close right"),
		map("x", "n", function() vim.cmd("BufferLineCloseOthers") end, "Close others"),
		map("t", "n", function()
			if vim.o.showtabline == 0 then
				vim.opt.showtabline = 2
			else
				vim.opt.showtabline = 0
			end
		end, "Toggle tabline"),
	},
	config = function()
		-- local transparent = "#000000"
		require("bufferline").setup({
			options = {
				numbers = "none", -- "ordinal", "buffer_id", "both"
				diagnostics = "nvim_lsp",
				always_show_bufferline = false,
				separator_style = { "|", "|" }, -- "slant", "slope", "thick", "thin", { "", "" }
				indicator = { style = "none" }, -- "icon", "underline", "none"
				show_buffer_close_icons = false,
				color_icons = true,
				sort_by = "insert_at_end",
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo Tree",
						highlight = "Directory",
						separator = true -- use a "true" to enable the default, or set your own character
					},
					{
						filetype = "dapui_watches",
						text = "DAP UI",
						highlight = "Directory",
						separator = true -- use a "true" to enable the default, or set your own character
					},
				},
			},
			highlights = {
				separator = { fg = "#777777", },
				-- Needed when using separator
				-- fill                   = { bg = transparent, },
				-- tab_separator          = { fg = transparent, },
				-- tab_separator_selected = { fg = transparent, },
				-- separator_selected     = { fg = transparent, bg = transparent },
				-- separator_visible      = { fg = transparent, },
				-- offset_separator       = { fg = transparent, },
			},
		})
	end,
	dependencies = "nvim-tree/nvim-web-devicons",
}

return spec
