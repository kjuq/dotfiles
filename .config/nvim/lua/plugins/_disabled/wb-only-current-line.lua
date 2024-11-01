---@type LazySpec
local spec = { 'yutkat/wb-only-current-line.nvim' }

spec.keys = {
	{ 'w', mode = { 'n', 'x' } },
	{ 'b', mode = { 'n', 'x' } },
	{ 'W', mode = { 'n', 'x' } },
	{ 'B', mode = { 'n', 'x' } },
}

return spec
