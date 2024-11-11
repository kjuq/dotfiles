-- TODO: <C-w> during Henkan causes a weird behavior

local skk = require('utils.skk')

---@type LazySpec
local spec = { 'vim-skk/skkeleton' }
spec.cond = vim.fn.executable('deno') ~= 0

spec.event = { 'User UserDenopsActivated', 'InsertEnter' }

spec.keys = skk.mappings('Skkeleton: ', 'skkeleton-enable', 'skkeleton-disable', 'skkeleton-toggle')

spec.config = function()
	-- create $XDG_CONFIG_HOME/skk dir if it doesn't exist
	if vim.fn.isdirectory(skk.skk_dir) == 0 then
		vim.fn.mkdir(skk.skk_dir, 'p')
	end

	local lazy_root = require('lazy.core.config').options.root

	vim.fn['skkeleton#config']({
		eggLikeNewline = false,
		setUndoPoint = false,
		globalDictionaries = {
			vim.fs.joinpath(lazy_root, 'dict', 'SKK-JISYO.L'),
			vim.fs.joinpath(lazy_root, 'dict', 'SKK-JISYO.jinmei'),
		},
		userDictionary = skk.jisyo_user,
	})

	vim.fn['skkeleton#register_kanatable']('rom', {
		['!'] = { '!', '' },
		['?'] = { '?', '' },
		[':'] = { ':', '' },
		['~'] = { '～', '' },
	})

	vim.fn['skkeleton#register_keymap']('henkan', '<C-h>', 'henkanBackward')
	vim.fn['skkeleton#register_keymap']('henkan', '<C-w>', 'cancel')
	vim.fn['skkeleton#register_keymap']('henkan', '<C-y>', 'kakutei')
	vim.fn['skkeleton#register_keymap']('input', '<C-y>', 'kakutei')

	vim.cmd([[ call add(g:skkeleton#mapped_keys, '<C-w>') ]])
	vim.cmd([[ call add(g:skkeleton#mapped_keys, '<C-y>') ]])

	-- remove "<C-g>" from mapped_keys
	local remove_mapped_keys = function(key)
		local mapped_keys = {}
		for _, v in ipairs(vim.g['skkeleton#mapped_keys']) do
			if v ~= key then
				table.insert(mapped_keys, v)
			end
		end
		vim.g['skkeleton#mapped_keys'] = mapped_keys
	end
	remove_mapped_keys('<C-g>')
	remove_mapped_keys('<C-j>')
end

spec.specs = {
	'skk-dev/dict',
}

spec.dependencies = {
	'vim-denops/denops.vim',
	{
		'delphinus/skkeleton_indicator.nvim',
		opts = {
			alwaysShown = false,
			fadeOutMs = 0,
			zindex = 9999,
		},
	},
}

return spec
