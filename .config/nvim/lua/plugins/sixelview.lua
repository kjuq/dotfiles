---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/kjuq/sixelview.nvim' }

spec.event = 'VeryLazy'

spec.opts = {
	delay_ms = 10,
}

spec.config = function(_, opts)
	require('sixelview').setup(opts)
	vim.schedule(function()
		local path = vim.fn.expand('%:p')
		local default_pat = require('sixelview.config').default.pattern
		local pattern = not opts.pattern and default_pat or opts.pattern
		local is_image_buffer = require('sixelview.utils').is_image_buffer(path, pattern)
		if is_image_buffer then
			vim.cmd.SixelView()
		end
	end)
end

return spec
