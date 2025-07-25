---@type LazySpec
local spec = { 'https://github.com/yutkat/wb-only-current-line.nvim' }

spec.keys = {
	{ 'w', mode = { 'n', 'x' } },
	{ 'b', mode = { 'n', 'x' } },
	{ 'W', mode = { 'n', 'x' } },
	{ 'B', mode = { 'n', 'x' } },
}

return spec
