return {
	"goolord/alpha-nvim",
	cond = vim.fn.argc() == 0, -- if nvim was launched without files specified by args
	event = { "BufWinEnter" },
	config = function()
		require("alpha").setup(require("alpha.themes.theta").config)
	end,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
}
