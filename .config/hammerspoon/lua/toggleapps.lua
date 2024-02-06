local M = {}

M.toggle_app = function(appName)
	local app = hs.application.get(appName)
	if app:isFrontmost() then
		app:hide()
	else
		hs.application.launchOrFocus(appName)
	end
end

return M
