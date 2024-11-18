---@type LazySpec
local spec = { 'kevinhwang91/nvim-bqf' }
spec.ft = 'qf'

spec.opts = function()
	vim.api.nvim_create_autocmd({ 'FileType' }, {
		pattern = 'qf',
		group = vim.api.nvim_create_augroup('kjuq_bqf_keymap', {}),
		callback = function()
			local rhs = function()
				require('bqf.preview.handler').hideWindow()
				vim.cmd([[execute "normal! \<C-w>w"]])
			end
			vim.keymap.set('n', '<C-w><C-w>', rhs, { buffer = true, desc = 'Bqf: move window' })
			vim.keymap.set('n', '<C-w>w', rhs, { buffer = true, desc = 'Bqf: move window' })
		end,
		desc = 'Hide preview before moving windows with <C-w>w and <C-w><C-w>',
	})
	return {
		preview = {
			auto_preview = true,
			winblend = 0,
		},
		func_map = {
			open = 'o', -- <CR>
			openc = '<CR>', -- "o"
			drop = '<Nop>', -- "O" (I have no idea what this is)
			tabdrop = '<Nop>', -- ""
			tab = '<Nop>', -- "t"
			tabb = '<Nop>', -- "T"
			tabc = '<Nop>', -- "<C-t>"
			split = '<Nop>', -- "<C-x>"
			vsplit = '<C-s>', -- "<C-v>"
			prevfile = '<C-p>', -- "<C-p>"
			nextfile = '<C-n>', -- "<C-n>"
			prevhist = '<', -- "<"
			nexthist = '>', -- ">"
			lastleave = '\'"', -- "'\""
			stoggleup = '<Nop>', -- "<S-Tab>" (Substitution for Qfedit)
			stoggledown = '<Nop>', -- "<Tab>" (Substitution for Qfedit)
			stogglevm = '<Nop>', -- "<Tab>" (Substitution for Qfedit)
			stogglebuf = '<Nop>', -- "'<Tab>" (Substitution for Qfedit)
			sclear = '<Nop>', -- "z<Tab>" (Substitution for Qfedit)
			pscrollup = '<C-b>', -- "<C-b>"
			pscrolldown = '<C-f>', -- "<C-f>"
			pscrollorig = 'zo', -- "zo"
			ptogglemode = 'zp', -- "zp"
			ptoggleitem = '<Nop>', -- "p"
			ptoggleauto = 'K', -- "P"
			filter = '<Nop>', -- "zn" (Substitution for Qfedit)
			filterr = '<Nop>', -- "zN" (Substitution for Qfedit)
			fzffilter = '<Nop>', -- "zf" (fzf isn't installed)
		},
	}
end

spec.dependencies = {
	'nvim-treesitter/nvim-treesitter',
}

return spec
