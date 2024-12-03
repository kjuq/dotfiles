---@type LazySpec
local spec = { 'dstein64/vim-startuptime' }
spec.cmd = { 'StartupTime' }

spec.config = function()
	vim.g.startuptime_tries = 10
end

return spec
