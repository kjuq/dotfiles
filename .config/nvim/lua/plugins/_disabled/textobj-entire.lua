---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/kana/vim-textobj-entire' }

spec.keys = {
	{ 'i', mode = '' },
	{ 'a', mode = '' },
}

spec.dependencies = {
	'kana/vim-textobj-user',
}

return spec
