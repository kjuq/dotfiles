return {
	"kevinhwang91/nvim-bqf",
	ft = "qf",
	opts = function()
		return {
			preview = {
				auto_preview = true,
				winblend = 0,
			},
			func_map = {
				open = "<CR>", -- <CR>
				openc = "o", -- "o"
				drop = "<Nop>", -- "O" (I have no idea what this is)
				tabdrop = "<Nop>", -- ""
				tab = "<Nop>", -- "t"
				tabb = "<Nop>", -- "T"
				tabc = "<Nop>", -- "<C-t>"
				split = "<Nop>", -- "<C-x>"
				vsplit = "<C-s>", -- "<C-v>"
				prevfile = "<C-p>", -- "<C-p>"
				nextfile = "<C-n>", -- "<C-n>"
				prevhist = "<", -- "<"
				nexthist = ">", -- ">"
				lastleave = "'\"", -- "'\""
				stoggleup = "X", -- "<S-Tab>" (Substitution for Qfedit)
				stoggledown = "x", -- "<Tab>" (Substitution for Qfedit)
				stogglevm = "x", -- "<Tab>" (Substitution for Qfedit)
				stogglebuf = "a", -- "'<Tab>" (Substitution for Qfedit)
				sclear = "U", -- "z<Tab>" (Substitution for Qfedit)
				pscrollup = "<C-b>", -- "<C-b>"
				pscrolldown = "<C-f>", -- "<C-f>"
				pscrollorig = "zo", -- "zo"
				ptogglemode = "zp", -- "zp"
				ptoggleitem = "<Nop>", -- "p"
				ptoggleauto = "K", -- "P"
				filter = "D", -- "zn" (Substitution for Qfedit)
				filterr = "d", -- "zN" (Substitution for Qfedit)
				fzffilter = "<Nop>", -- "zf" (fzf isn't installed)
			},
		}
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
}
