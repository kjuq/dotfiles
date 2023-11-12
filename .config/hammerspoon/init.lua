-- Execute the command below when setting up a new environment
-- defaults write org.hammerspoon.Hammerspoon MJConfigFile "$XDG_CONFIG_HOME/hammerspoon/init.lua"

local hs_base = "$XDG_CONFIG_HOME/hammerspoon"
local cmd_opt = { "cmd", "option" }
local cmd_opt_ctrl = { "cmd", "option", "ctrl" }

-- Toggle apps {{{
hs.ipc.cliInstall("/opt/homebrew")

local appsToHide = {}

local function toggleApp(appName, mods, key)
	hs.hotkey.bind(mods, key, function()
		local app = hs.application.get(appName)
		if app:isFrontmost() then
			app:hide()
		else
			hs.application.launchOrFocus(appName)
		end
	end)
	table.insert(appsToHide, appName)
end
local function hideAllApps()
	for _, appname in pairs(appsToHide) do
		local app = hs.application.get(appname)
		app:hide()
	end
end

toggleApp("System Settings", cmd_opt_ctrl, "/")
toggleApp("Safari", cmd_opt_ctrl, ",")
toggleApp("Alacritty", cmd_opt_ctrl, "/")
toggleApp("Vivaldi", cmd_opt_ctrl, "[")
toggleApp("Wezterm", cmd_opt_ctrl, "]")
hs.hotkey.bind(cmd_opt_ctrl, "-", hideAllApps)
toggleApp("Finder", cmd_opt_ctrl, "=")

-- }}}

-- Window movement {{{
-- https://qiita.com/haruyama480/items/bf9e6a42fedbdbbaf438
DURATION = 0.05
DELTA = 10
local function moveDown()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	f.y = f.y + DELTA
	win:setFrameInScreenBounds(f, DURATION)
end

local function moveUp()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	f.y = f.y - DELTA
	win:setFrameInScreenBounds(f, DURATION)
end

local function moveLeft()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	f.x = f.x - DELTA
	win:setFrameInScreenBounds(f, DURATION)
end

local function moveRight()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	f.x = f.x + DELTA
	win:setFrameInScreenBounds(f, DURATION)
end

hs.hotkey.bind(cmd_opt, "f", moveUp, nil, moveUp)
hs.hotkey.bind(cmd_opt, "right", moveUp, nil, moveUp)
hs.hotkey.bind(cmd_opt, "s", moveDown, nil, moveDown)
hs.hotkey.bind(cmd_opt, "r", moveLeft, nil, moveLeft)
hs.hotkey.bind(cmd_opt, "t", moveRight, nil, moveRight)

hs.hotkey.bind(cmd_opt, "a", function() hs.window.focusedWindow():moveOneScreenWest() end)
hs.hotkey.bind(cmd_opt, "o", function() hs.window.focusedWindow():moveOneScreenEast() end)
-- }}}

-- Window separation {{{
hs.window.animationDuration = 0
local units = {
	right       = { x = 0.50, y = 0.00, w = 0.50, h = 1.00 },
	left        = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 },
	top         = { x = 0.00, y = 0.00, w = 1.00, h = 0.50 },
	bot         = { x = 0.00, y = 0.50, w = 1.00, h = 0.50 },
	upperRight  = { x = 0.50, y = 0.00, w = 0.50, h = 0.50 },
	upperLeft   = { x = 0.00, y = 0.00, w = 0.50, h = 0.50 },
	bottomRight = { x = 0.50, y = 0.50, w = 0.50, h = 0.50 },
	bottomLeft  = { x = 0.00, y = 0.50, w = 0.50, h = 0.50 },
}

hs.hotkey.bind(cmd_opt, "i", function() hs.window.focusedWindow():move(units.right, nil, true) end)
hs.hotkey.bind(cmd_opt, "n", function() hs.window.focusedWindow():move(units.left, nil, true) end)
hs.hotkey.bind(cmd_opt, "u", function() hs.window.focusedWindow():move(units.top, nil, true) end)
hs.hotkey.bind(cmd_opt, ",", function() hs.window.focusedWindow():move(units.bot, nil, true) end)

hs.hotkey.bind(cmd_opt, "y", function() hs.window.focusedWindow():move(units.upperRight, nil, true) end)
hs.hotkey.bind(cmd_opt, "l", function() hs.window.focusedWindow():move(units.upperLeft, nil, true) end)
hs.hotkey.bind(cmd_opt, ".", function() hs.window.focusedWindow():move(units.bottomRight, nil, true) end)
hs.hotkey.bind(cmd_opt, "m", function() hs.window.focusedWindow():move(units.bottomLeft, nil, true) end)

hs.hotkey.bind(cmd_opt, "e", function() hs.window.focusedWindow():maximize() end)
-- }}}

-- Mouse button remaps {{{

local middleButton = 2
local backButton = 3
local forwardButton = 4

local finderMouseEvent = hs.eventtap.new({ hs.eventtap.event.types.otherMouseDown }, function(e)
	-- print(hs.eventtap.event.properties['mouseEventButtonNumber'])
	local mouseButton = e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber'])
	if mouseButton == middleButton then
		hs.eventtap.event.newKeyEvent("cmd", "delete", true):post()
		return true
	end
	if mouseButton == backButton then
		hs.eventtap.event.newKeyEvent("cmd", "[", true):post()
		return true
	end
	if mouseButton == forwardButton then
		hs.eventtap.event.newKeyEvent("cmd", "]", true):post()
		return true
	end
end)

-- App-specific remaps

local function handleGlobalEvent(name, event, _) -- name, event, APP
	if event == hs.application.watcher.activated then
		if name == "Finder" then
			finderMouseEvent:start()
		else
			finderMouseEvent:stop()
		end
	end
end

local watcher = hs.application.watcher.new(handleGlobalEvent)
watcher:start()

-- }}}

-- Simple remaps {{{
hs.hotkey.bind({ "cmd" }, "q", function() hs.eventtap.keyStroke("cmd", "`") end)
hs.hotkey.bind(cmd_opt, "g", function() hs.eventtap.keyStroke("cmd", "`") end)
-- }}}

-- Check if the file exists
local function path_exists(path)
	local f = io.open(path, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

-- if not path_exists(hs_base .. "/Spoons/EmmyLua.spoon") then
-- 	hs.alert("EmmyLua is not installed")
-- else
hs.loadSpoon("EmmyLua")
-- end
