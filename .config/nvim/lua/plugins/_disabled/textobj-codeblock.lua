---@type LazySpec
local spec = { 'christoomey/vim-textobj-codeblock' }
spec.keys = {
	{ 'i', mode = '' },
	{ 'a', mode = '' },
}
spec.dependencies = {
	'kana/vim-textobj-user',
}

return spec

-- ic: Contents of the codeblock
-- ac: Entire codeblock, including backtick lines
