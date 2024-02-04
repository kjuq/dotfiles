-- This plugin is buggy
-- Weird behavior in typing cmd

---@type LazySpec
local spec = {
	"winston0410/range-highlight.nvim",
	event = { "CmdlineEnter" },
	opts = {},
	dependencies = {
		"winston0410/cmd-parser.nvim"
	}
}

return spec
