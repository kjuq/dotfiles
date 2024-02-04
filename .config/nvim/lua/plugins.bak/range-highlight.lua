-- This plugin is buggy
-- Weird behavior in typing cmd

return {
	"winston0410/range-highlight.nvim",
	event = { "CmdlineEnter" },
	opts = {},
	dependencies = {
		"winston0410/cmd-parser.nvim"
	}
}
