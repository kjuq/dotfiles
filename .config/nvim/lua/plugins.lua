-- init.lua
local plugin_dir = vim.fn.stdpath('config') .. '/lua/plugins'

for _, path in ipairs(vim.fn.globpath(plugin_dir, '*.lua', false, true)) do
	local name = vim.fn.fnamemodify(path, ':t:r')
	require('plugins.' .. name)
end
