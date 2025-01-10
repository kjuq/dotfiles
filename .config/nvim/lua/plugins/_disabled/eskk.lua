local skk = require('kjuq.utils.skk')

---@type LazySpec
local spec = { 'vim-skk/eskk.vim' }
spec.keys = skk.mappings('Eskk: ', 'eskk:enable', 'eskk:disable', 'eskk:toggle')

spec.config = function()
	local lazy_root = require('lazy.core.config').options.root
	local large_dict = vim.fs.joinpath(lazy_root, 'dict', 'SKK-JISYO.L')

	vim.g['eskk#directory'] = skk.skk_dir
	vim.g['eskk#dictionary'] = { path = skk.jisyo_user, sorted = 1, encoding = 'utf-8' }
	vim.g['eskk#large_dictionary'] = { path = large_dict, sorted = 1, encoding = 'euc-jp' }
	vim.g['eskk#egg_like_newline'] = 0
	vim.g['eskk#keep_state'] = 0
	vim.g['eskk#enable_completion'] = 0
	vim.g['eskk#no_default_mappings'] = 1

	vim.api.nvim_create_autocmd('User', {
		pattern = 'eskk-initialize-pre',
		callback = function()
			vim.cmd([[ let t = eskk#table#new("rom_to_hira*", "rom_to_hira") ]])
			vim.cmd([[ call t.add_map("!", "!") ]])
			vim.cmd([[ call t.add_map("?", "?") ]])
			vim.cmd([[ call t.add_map(":", ":") ]])
			vim.cmd([[ call t.add_map("~", "～") ]])
			vim.cmd([[ call t.add_map("z ", "　") ]])
			vim.cmd([[ call eskk#register_mode_table("hira", t) ]])
		end,
	})

	local has_noice, _ = pcall(require, 'noice')
	vim.api.nvim_create_autocmd('User', {
		pattern = 'eskk-enable-pre',
		callback = function()
			if has_noice then
				vim.cmd('Noice disable')
			end
		end,
	})
	vim.api.nvim_create_autocmd('User', {
		pattern = 'eskk-disable-post',
		callback = function()
			if has_noice then
				vim.cmd('Noice enable')
			end
		end,
	})
end

spec.dependencies = {
	'skk-dev/dict',
}

return spec
