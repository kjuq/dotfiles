---@type LazySpec
local spec = { "chrisgrieser/nvim-various-textobjs" }

local map = require("utils.lazy").generate_map("", "Various-textobjs: ")
spec.keys = {
	map("ii", { "o", "x" }, function()
		require("various-textobjs").indentation("inner", "inner", "noBlanks")
	end, "Indentation (inner without blanks)"),
	map("ai", { "o", "x" }, function()
		require("various-textobjs").indentation("outer", "outer", "noBlanks")
	end, "Indentation (outer without blanks)"),

	map("iI", { "o", "x" }, function()
		require("various-textobjs").indentation("inner", "inner", "withBlanks")
	end, "Indentation (inner with blanks)"),
	map("aI", { "o", "x" }, function()
		require("various-textobjs").indentation("outer", "outer", "withBlanks")
	end, "Indentation (outer with blanks)"),

	map("iS", { "o", "x" }, function()
		require("various-textobjs").subword("inner", "inner")
	end, "Subword (inner)"),
	map("aS", { "o", "x" }, function()
		require("various-textobjs").subword("outer", "outer")
	end, "Subword (outer)"),

	map("iq", { "o", "x" }, function()
		require("various-textobjs").anyQuote("inner", "inner")
	end, "Any Quote (inner)"),
	map("aq", { "o", "x" }, function()
		require("various-textobjs").anyQuote("outer", "outer")
	end, "Any Quote (outer)"),

	map("ib", { "o", "x" }, function()
		require("various-textobjs").anyBracket("inner", "inner")
	end, "Any Bracket (inner)"),
	map("ab", { "o", "x" }, function()
		require("various-textobjs").anyBracket("outer", "outer")
	end, "Any Bracket (outer)"),

	map("gG", { "o", "x" }, function()
		require("various-textobjs").entireBuffer()
	end, "Entire Buffer"),

	map("ic", { "o", "x" }, function()
		if vim.o.ft == "python" then
			require("various-textobjs").pyTripleQuotes("inner", "inner")
		else
			require("various-textobjs").mdFencedCodeBlock("inner", "inner")
		end
	end, "Fenced code block (inner)"),
	map("ac", { "o", "x" }, function()
		if vim.o.ft == "python" then
			require("various-textobjs").pyTripleQuotes("outer", "outer")
		else
			require("various-textobjs").mdFencedCodeBlock("outer", "outer")
		end
	end, "Fenced code block (outer)"),
}

spec.opts = {
	lookForwardSmall = 5,
	lookForwardBig = 15,

	useDefaultKeymaps = false,
	notifyNotFound = false,
}

return spec
