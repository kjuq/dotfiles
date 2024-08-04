---@type LazySpec
local spec = { 'kevinhwang91/nvim-bqf' }
spec.ft = 'qf'

spec.opts = function()
	return {
		preview = {
			auto_preview = true,
			winblend = 0,
		},
		func_map = {
			open = '<CR>', -- <CR>
			openc = 'o', -- "o"
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
