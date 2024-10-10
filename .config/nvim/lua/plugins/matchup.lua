---@type LazySpec
local spec = { 'andymass/vim-matchup' }
spec.event = 'VeryLazy'

spec.config = function()
	---@diagnostic disable-next-line: missing-fields
	require('nvim-treesitter.configs').setup({
		matchup = {
			enable = true,
			enable_quotes = true,
			disable_virtual_text = true,
		},
	})
	-- for lazy-load, reload filetype
	-- TODO: use `:MatchupReload` ?
	vim.bo.filetype = vim.bo.filetype

	local is_big_file = function()
		local max_line = 50000
		return vim.api.nvim_buf_line_count(0) > max_line
	end

	local reenable = function()
		vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
			group = vim.api.nvim_create_augroup('kjuq_matchup_enable', {}),
			callback = function()
				vim.cmd('DoMatchParen')
			end,
			once = true,
		})
	end

	local disable = function()
		vim.schedule(function()
			if is_big_file() then
				vim.cmd('NoMatchParen')
				reenable()
			end
		end)
	end

	disable()
	vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
		group = vim.api.nvim_create_augroup('kjuq_matchup_disable', {}),
		callback = disable,
	})
end

spec.dependencies = {
	'nvim-treesitter/nvim-treesitter',
}

return spec
