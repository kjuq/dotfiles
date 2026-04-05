local M = {}

M.toggle_app = function(appName)
	hs.application.launchOrFocus(appName)
end

return M
