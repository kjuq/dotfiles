---@type LazySpec
local spec = { "vim-jp/vimdoc-ja" }
spec.lazy = false

spec.init = function()
	vim.opt.helplang = { "ja", "en" }
end

return spec
