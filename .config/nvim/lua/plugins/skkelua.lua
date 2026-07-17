---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/kjuq/skkelua.nvim' }

spec.event = { 'InsertEnter' }

spec.config = function()
	vim.keymap.set('i', '<C-Space>', '<Plug>(skkelua-enable)')
	vim.keymap.set('n', '<Space>tj', '<Plug>(skkelua-persistent-toggle)')

	local skkelua = require('skkelua')

	local mapped_keys = {}
	for _, v in ipairs(skkelua.get_default_mapped_keys()) do
		if v ~= '<C-g>' and v ~= '<C-j>' then
			table.insert(mapped_keys, v)
		end
	end

	skkelua.config({
		globalDictionaries = {
			vim.fs.joinpath(require('lazy.core.config').options.root, 'dict', 'SKK-JISYO.L'),
			vim.fs.joinpath(require('lazy.core.config').options.root, 'dict', 'SKK-JISYO.jinmei'),
		},
		mappedKeys = mapped_keys,
		completion = {
			enabled = true,
			insertOnSelect = true,
			deferOkuri = true, -- TODO: delete `deferOkuri`, make always defer Okuri when completion is enabled
		},
		pureSpace = true,
		indicator = {
			alwaysShown = false,
			fadeOutMs = 0,
			zindex = 1,
			-- border = 'single',
		},
	})

	skkelua.register_kanatable('rom', {
		['!'] = { '!', '' },
		['?'] = { '?', '' },
		[':'] = { ':', '' },
		['~'] = { '～', '' },
	})
	skkelua.register_keymap('henkan', 'x', '')
end

spec.specs = {
	'skk-dev/dict',
}

return spec
