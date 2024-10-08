hs.ipc.cliInstall('/opt/homebrew')

local cmd_opt = { 'cmd', 'option' }
local cmd_opt_ctrl = { 'cmd', 'option', 'ctrl' }

local bind = hs.hotkey.bind

local floatingnvim = require('lua.floatingnvim')
bind(cmd_opt_ctrl, '`', floatingnvim.toggle)

local toggleapps = require('lua.toggleapps')
bind(cmd_opt_ctrl, '.', function()
	toggleapps.toggle_app('Vivaldi')
end)
bind(cmd_opt_ctrl, ',', function()
	toggleapps.toggle_app('System Settings')
end)
bind(cmd_opt_ctrl, ']', function()
	toggleapps.toggle_app('Wezterm')
end)
bind(cmd_opt_ctrl, '[', function()
	toggleapps.toggle_app('qutebrowser')
end)
bind(cmd_opt_ctrl, '/', function()
	toggleapps.toggle_app('Preview')
end)
bind(cmd_opt_ctrl, "'", function()
	toggleapps.toggle_app('Alacritty')
end)
bind(cmd_opt_ctrl, '=', function()
	toggleapps.toggle_app('Finder')
end)

local movewin = require('lua.movewin')
bind(cmd_opt, 'f', movewin.up, nil, movewin.up)
bind(cmd_opt, 'right', movewin.up, nil, movewin.up)
bind(cmd_opt, 's', movewin.down, nil, movewin.down)
bind(cmd_opt, 'r', movewin.left, nil, movewin.left)
bind(cmd_opt, 't', movewin.right, nil, movewin.right)
bind(cmd_opt, 'a', function()
	hs.window.focusedWindow():moveOneScreenWest()
end)
bind(cmd_opt, 'o', function()
	hs.window.focusedWindow():moveOneScreenEast()
end)

local snap = require('lua.snap')
bind(cmd_opt, 'i', snap.right)
bind(cmd_opt, 'n', snap.left)
bind(cmd_opt, 'u', snap.top)
bind(cmd_opt, ',', snap.bot)
bind(cmd_opt, 'y', snap.upper_right)
bind(cmd_opt, 'l', snap.upper_left)
bind(cmd_opt, '.', snap.bottom_right)
bind(cmd_opt, 'm', snap.bottom_left)
bind(cmd_opt, 'h', snap.center)

bind(cmd_opt, 'e', function()
	hs.window.focusedWindow():maximize()
end)

bind({}, 'F20', function() end)

hs.loadSpoon('EmmyLua')
