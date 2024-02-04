return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 9999,
	config = function()
		require('kanagawa').setup({
			transparent = false, -- imperfect
			dimInactive = true,  -- dim inactive window `:h hl-NormalNC`
			theme = "wave",      -- Load "wave" theme when 'background' option is not set
			background = {       -- map the value of 'background' option to a theme
				dark = "wave",   -- try "dragon" !
				light = "lotus"
			},
		})
		vim.cmd.colorscheme("kanagawa")
	end,
}
