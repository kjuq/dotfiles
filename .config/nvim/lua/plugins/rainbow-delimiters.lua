---@type LazySpec
local spec = { "HiPhish/rainbow-delimiters.nvim" }
spec.event = require("utils.lazy").verylazy
spec.tag = "v0.2.0"

spec.config = function()
	local rainbow = require("rainbow-delimiters")

	vim.api.nvim_set_hl(0, "RainbowNord1", { fg = "#8FBCBB" })
	vim.api.nvim_set_hl(0, "RainbowNord2", { fg = "#88C0D0" })
	vim.api.nvim_set_hl(0, "RainbowNord3", { fg = "#81A1C1" })
	vim.api.nvim_set_hl(0, "RainbowNord4", { fg = "#5E81AC" })

	vim.api.nvim_set_hl(0, "RainbowAurora1", { fg = "#BF616A" })
	vim.api.nvim_set_hl(0, "RainbowAurora2", { fg = "#D08770" })
	vim.api.nvim_set_hl(0, "RainbowAurora3", { fg = "#EBCB8B" })
	vim.api.nvim_set_hl(0, "RainbowAurora4", { fg = "#A3BE8C" })
	vim.api.nvim_set_hl(0, "RainbowAurora5", { fg = "#B48EAD" })

	vim.g.rainbow_delimiters = {
		strategy = {
			[""] = function()
				if vim.fn.line("$") > 3000 then
					return nil
				else
					return rainbow.strategy["global"]
				end
			end,
		},
		highlight = {
			"RainbowAurora1",
			"RainbowNord4",
			"RainbowAurora4",
			"RainbowAurora5",
		},
	}
	rainbow.enable()
end

spec.dependencies = {
	"nvim-treesitter/nvim-treesitter",
}

return spec
