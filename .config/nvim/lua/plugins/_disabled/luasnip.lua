local map = require('kjuq.utils.lazy').generate_map('', 'Luasnip: ')

---@type LazySpec
local spec = { 'L3MON4D3/LuaSnip' }

spec.keys = {
	map('<C-k>', { 'i', 's' }, function()
		if require('luasnip').expand_or_locally_jumpable() then
			require('luasnip').expand_or_jump()
		end
	end, 'expand or jump to a next placeholder'),
	map('<C-M-k>', { 'i', 's' }, function()
		if require('luasnip').expand_or_locally_jumpable() then
			require('luasnip').jump(-1)
		end
	end, 'jump to a previous placeholder'),
}

spec.config = function()
	require('luasnip.loaders.from_snipmate').lazy_load()
end

return spec
