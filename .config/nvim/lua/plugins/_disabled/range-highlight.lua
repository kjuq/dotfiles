---@type LazySpec
local spec = { 'winston0410/range-highlight.nvim' }
spec.event = { 'CmdlineEnter' }
spec.opts = {}

spec.dependencies = {
	'winston0410/cmd-parser.nvim',
}

return spec

-- This plugin is buggy
-- Weird behavior in typing cmd
