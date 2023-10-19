-- Execute the command below when setting up a new environment
-- defaults write org.hammerspoon.Hammerspoon MJConfigFile "$XDG_CONFIG_HOME/hammerspoon/init.lua"

function toggleApp(appName, key)
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

toggleApp("WezTerm", "f17")
toggleApp("Vivaldi", "f18")
