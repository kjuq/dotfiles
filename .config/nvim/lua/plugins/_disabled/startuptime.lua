---@type LazySpec
local spec = { 'https://github.com/dstein64/vim-startuptime' }
spec.cmd = { 'StartupTime' }

spec.config = function()
	vim.g.startuptime_tries = 10
end

return spec
