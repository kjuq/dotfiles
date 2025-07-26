---@type LazySpec
local spec = { 'https://github.com/miversen33/sunglasses.nvim' }
spec.event = 'VeryLazy'

spec.config = function()
	-- local group = vim.api.nvim_create_augroup("kjuq_sunglasses", {})
	-- vim.api.nvim_create_autocmd({ "FocusLost" }, {
	-- 	group = group,
	-- 	callback = function()
	-- 		vim.cmd("SunglassesOn")
	-- 	end,
	-- })
	-- vim.api.nvim_create_autocmd({ "FocusGained" }, {
	-- 	group = group,
	-- 	callback = function()
	-- 		vim.cmd("SunglassesOff")
	-- 	end,
	-- })

	require('sunglasses').setup({
		filter_type = 'SHADE',
		filter_percent = 0.40,
	})

	vim.cmd('SunglassesRefresh') -- for lazy load
end

return spec
