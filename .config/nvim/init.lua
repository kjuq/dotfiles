vim.loader.enable()

local myvimrc = os.getenv('MYVIMRC')
local luahome = myvimrc and vim.fn.fnamemodify(myvimrc, ':p:h') .. '/lua' or nil -- mostly `$XDG_CONFIG_HOME/nvim/lua`
if luahome and vim.uv.fs_stat(luahome .. '/initprelocal.lua') then
	require('initprelocal')
end

require('core.general')
require('core.options')
require('core.keymaps')
require('core.commands')
require('core.mouse')
require('core.colorscheme')

require('core.lazy')

if myvimrc and vim.uv.fs_stat(luahome .. '/initpostlocal.lua') then
	require('initpostlocal')
end
