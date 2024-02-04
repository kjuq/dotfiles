local expand_key = "<Tab>"

return {
	"dcampos/nvim-snippy",
	keys = {
		{ expand_key, mode = { "i" } },
	},
	opts = {
		mappings = {
			is = {
				[expand_key] = "expand_or_advance",
				["<S-Tab>"] = "previous",
			},
		},
	},
	dependencies = {
		"honza/vim-snippets",
	},
}
