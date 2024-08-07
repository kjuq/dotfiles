---@type LazySpec
local spec = { 'miversen33/sunglasses.nvim' }
spec.event = 'VeryLazy'

spec.config = function()
	-- vim.api.nvim_create_autocmd({ "FocusLost" }, {
	-- 	group = vim.api.nvim_create_augroup("sunglasses_unfocuesd", {}),
	-- 	callback = function()
	-- 		vim.cmd("SunglassesOn")
	-- 	end,
	-- })
	-- vim.api.nvim_create_autocmd({ "FocusGained" }, {
	-- 	group = vim.api.nvim_create_augroup("sunglasses_focused", {}),
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
