---@type LazySpec
local spec = { 'https://github.com/HiPhish/rainbow-delimiters.nvim' }
spec.event = 'VeryLazy'

spec.config = function()
	local rainbow = require('rainbow-delimiters')

	vim.api.nvim_set_hl(0, 'RainbowNord1', { fg = '#8FBCBB' })
	vim.api.nvim_set_hl(0, 'RainbowNord2', { fg = '#88C0D0' })
	vim.api.nvim_set_hl(0, 'RainbowNord3', { fg = '#81A1C1' })
	vim.api.nvim_set_hl(0, 'RainbowNord4', { fg = '#5E81AC' })

	vim.api.nvim_set_hl(0, 'RainbowAurora1', { fg = '#BF616A' })
	vim.api.nvim_set_hl(0, 'RainbowAurora2', { fg = '#D08770' })
	vim.api.nvim_set_hl(0, 'RainbowAurora3', { fg = '#EBCB8B' })
	vim.api.nvim_set_hl(0, 'RainbowAurora4', { fg = '#A3BE8C' })
	vim.api.nvim_set_hl(0, 'RainbowAurora5', { fg = '#B48EAD' })

	vim.g.rainbow_delimiters = {
		strategy = {
			[''] = function(bufnr)
				local cmn = require('kjuq.utils.common')
				if cmn.is_bigfile(cmn.get_filepath_from_bufnr(bufnr)) or cmn.is_bigbuf(bufnr) then
					return nil
				end
				return rainbow.strategy['global'] -- default strategy
			end,
		},
		highlight = {
			'RainbowAurora1',
			'RainbowNord4',
			'RainbowAurora4',
			'RainbowAurora5',
		},
		blacklist = {
			'markdown',
			'help',
		},
	}

	rainbow.enable(0) -- for lazy load
end

spec.specs = {
	'nvim-treesitter/nvim-treesitter',
}

return spec
