-- `gc` and `gb` are mapped by default

---@type LazySpec
local spec = { 'numToStr/Comment.nvim' }

spec.keys = {
	{ 'gc', mode = { 'n', 'x', 'o' }, desc = 'Comment: add line comment' },
	{ 'gcc', mode = { 'n' }, desc = 'Comment: add line comment' },
}

spec.opts = {
	toggler = {
		line = 'gcc',
		block = '<Nop>',
	},
	opleader = {
		line = 'gc',
		block = '<Nop>',
	},
	extra = {
		above = 'gcO',
		below = 'gco',
		eol = 'gcA',
	},
	---Enable keybindings
	---NOTE: If given `false` then the plugin won't create any mappings
	mappings = {
		---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
		basic = true,
		---Extra mapping; `gco`, `gcO`, `gcA`
		extra = true,
	},
}

return spec
