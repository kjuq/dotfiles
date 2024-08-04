local map = require('utils.lazy').generate_map('', 'Luasnip: ')

---@type LazySpec
local spec = { 'L3MON4D3/LuaSnip' }

local key_next = '<C-k>'
local key_prev = '<C-M-k>'

spec.keys = {
	map(key_next, { 'i', 's' }, function()
		if require('luasnip').expand_or_locally_jumpable() then
			require('luasnip').expand_or_jump()
		else
			local key = vim.api.nvim_replace_termcodes(key_next, true, false, true)
			vim.api.nvim_feedkeys(key, 'n', false)
		end
	end, 'expand or jump to a next placeholder'),
	map(key_prev, { 'i', 's' }, function()
		if require('luasnip').expand_or_locally_jumpable() then
			require('luasnip').jump(-1)
		else
			local key = vim.api.nvim_replace_termcodes(key_prev, true, false, true)
			vim.api.nvim_feedkeys(key, 'n', false)
		end
	end, 'jump to a previous placeholder'),
}

spec.config = function() require('luasnip.loaders.from_snipmate').lazy_load() end

return spec
