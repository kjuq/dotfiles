-- Execute the command below when setting up a new environment
-- defaults write org.hammerspoon.Hammerspoon MJConfigFile "$XDG_CONFIG_HOME/hammerspoon/init.lua"

hs.ipc.cliInstall("/opt/homebrew")

local function toggleApp(appName, key)
	hs.hotkey.bind({}, key, function()
		local app = hs.application.get(appName)
		if app == nil then
			hs.application.launchOrFocus("/Applications/" .. appName .. ".app")
		elseif app:isFrontmost() then
			app:hide()
		else
			hs.application.launchOrFocus("/Applications/" .. appName .. ".app")
		end
	end)
end

local function hideAllApps()
	local appnames = { "WezTerm", "Vivaldi", "KeePassXC" }
	for _, appname in pairs(appnames) do
		local app = hs.application.get(appname)
		app:hide()
	end
end

hs.hotkey.bind({}, "f16", hideAllApps)
toggleApp("Vivaldi", "f17")
toggleApp("WezTerm", "f18")
toggleApp("KeePassXC", "f19")

-- Mouse button remaps

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
