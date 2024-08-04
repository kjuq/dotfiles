---@type LazySpec
local spec = { 'norcalli/nvim-colorizer.lua' }
spec.event = 'VeryLazy'

spec.config = function() -- `opts` not works
	require('colorizer').setup()
	vim.cmd('ColorizerAttachToBuffer')
end

return spec
