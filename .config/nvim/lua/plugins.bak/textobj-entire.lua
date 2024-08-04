---@type LazySpec
local spec = { 'kana/vim-textobj-entire' }

spec.keys = {
	{ 'i', mode = '' },
	{ 'a', mode = '' },
}

spec.dependencies = {
	'kana/vim-textobj-user',
}

return spec
