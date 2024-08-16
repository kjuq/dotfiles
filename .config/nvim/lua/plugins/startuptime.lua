local map = require('utils.lazy').generate_map('<leader>', 'Startuptime: ')

---@type LazySpec
local spec = { 'dstein64/vim-startuptime' }
spec.cmd = { 'StartupTime' }

spec.keys = {
	map('av', 'n', '<CMD>StartupTime<CR>', 'Calculate the time'),
}

spec.config = function()
	vim.g.startuptime_tries = 10
end

return spec
