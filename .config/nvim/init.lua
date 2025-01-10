vim.loader.enable()

local myvimrc = os.getenv('MYVIMRC')
local luahome = myvimrc and vim.fs.joinpath(vim.fn.fnamemodify(myvimrc, ':p:h'), 'lua') or nil -- mostly `$XDG_CONFIG_HOME/nvim/lua`
local localrc = vim.fs.joinpath(luahome, 'kjuq', 'rc', 'local')

-- if luahome and vim.uv.fs_stat(luahome .. '/initprelocal.lua') then
if luahome and vim.uv.fs_stat(vim.fs.joinpath(localrc, 'initpre.lua')) then
	require('kjuq.rc.local.initpre')
end

require('kjuq.rc.general')
require('kjuq.rc.options')
require('kjuq.rc.keymaps')
require('kjuq.rc.commands')
require('kjuq.rc.mouse')
require('kjuq.rc.colorscheme')

require('kjuq.rc.lazy')

-- if myvimrc and vim.uv.fs_stat(luahome .. '/initpostlocal.lua') then
if luahome and vim.uv.fs_stat(vim.fs.joinpath(localrc, 'initpost.lua')) then
	require('kjuq.rc.local.initpost')
end
