---@type LazySpec
local spec = {
	"vim-jp/vimdoc-ja",
	lazy = false,
	init = function()
		vim.opt.helplang = { "ja", "en" }
	end,
}

return spec
