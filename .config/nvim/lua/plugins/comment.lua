-- `gc` and `gb` are mapped by default

---@type LazySpec
local spec = { 'numToStr/Comment.nvim' }

spec.keys = {
	{ 'gc', mode = { 'n', 'x', 'o' }, desc = 'Comment: add line comment' },
	{ 'gcc', mode = { 'n' }, desc = 'Comment: add line comment' },
	{ 'gb', mode = { 'n', 'x' }, desc = 'Comment: add block comments' },
}

spec.opts = {}

return spec
