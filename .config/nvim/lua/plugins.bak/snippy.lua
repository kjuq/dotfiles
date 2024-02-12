local expand_key = "<Tab>"

---@type LazySpec
local spec = { "dcampos/nvim-snippy" }

spec.keys = {
	{ expand_key, mode = { "i" } },
}

spec.opts = {
	mappings = {
		is = {
			[expand_key] = "expand_or_advance",
			["<S-Tab>"] = "previous",
		},
	},
}

spec.dependencies = {
	"honza/vim-snippets",
}

return spec
