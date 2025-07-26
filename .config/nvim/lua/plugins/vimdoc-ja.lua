---@type LazySpec
local spec = { 'https://github.com/vim-jp/vimdoc-ja' }

spec.event = 'VeryLazy'

spec.keys = {
	{ 'h', mode = 'c' },
}

spec.init = function()
	vim.opt.helplang = { 'ja', 'en' }
end

return spec
