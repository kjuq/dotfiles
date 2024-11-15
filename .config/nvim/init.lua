vim.loader.enable()

local myvimrc = os.getenv('MYVIMRC')
if myvimrc and vim.uv.fs_stat(vim.fn.fnamemodify(myvimrc, ':p:h') .. '/lua/initprelocal.lua') then
	require('initprelocal')
end

require('core.general')
require('core.options')
require('core.keymaps')
require('core.commands')
require('core.mouse')
require('core.colorscheme')

require('core.lazy')

if myvimrc and vim.uv.fs_stat(vim.fn.fnamemodify(myvimrc, ':p:h') .. '/lua/initpostlocal.lua') then
	require('initpostlocal')
end
