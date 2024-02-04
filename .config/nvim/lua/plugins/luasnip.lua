local map = require("utils.lazy").generate_map("", "Luasnip: ")

---@type LazySpec
local spec = {
	"L3MON4D3/LuaSnip",
	keys = {
		map("<Tab>", { "i", "s" }, function()
			if require("luasnip").expand_or_jumpable() then
				require("luasnip").expand_or_jump()
			else
				local key = vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
				vim.api.nvim_feedkeys(key, "n", false)
			end
		end, "expand or jump to a next placeholder"),
		map("<S-Tab>", { "i", "s" }, function()
			if require("luasnip").expand_or_jumpable() then
				require("luasnip").jump(-1)
			else
				local key = vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true)
				vim.api.nvim_feedkeys(key, "n", false)
			end
		end, "jump to a previous placeholder"),
	},
	config = function()
		require("luasnip.loaders.from_snipmate").lazy_load()
	end,
}

return spec
