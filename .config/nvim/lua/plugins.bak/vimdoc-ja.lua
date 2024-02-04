return {
	"vim-jp/vimdoc-ja",
	lazy = false,
	init = function()
		vim.opt.helplang = { "ja", "en" }
	end,
}
