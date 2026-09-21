-- `git clone https://github.com/skk-dev/dict $XDG_DATA_HOME/nvim/skkelua/dict`
vim.pack.add({ 'https://github.com/kjuq/skkelua.nvim' })

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
		vim.fs.joinpath(vim.fn.stdpath('data'), 'skkelua', 'dict', 'SKK-JISYO.L'),
		vim.fs.joinpath(vim.fn.stdpath('data'), 'skkelua', 'dict', 'SKK-JISYO.jinmei'),
	},
	completionRankFile = vim.fs.joinpath(vim.fn.stdpath('state'), 'skkelua', 'rank'),
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
