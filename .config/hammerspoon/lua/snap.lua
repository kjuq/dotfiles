hs.window.animationDuration = 0

local M = {}

local units = {
	right        = { x = 0.50, y = 0.00, w = 0.50, h = 1.00 },
	left         = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 },
	top          = { x = 0.00, y = 0.00, w = 1.00, h = 0.50 },
	bot          = { x = 0.00, y = 0.50, w = 1.00, h = 0.50 },
	upper_right  = { x = 0.50, y = 0.00, w = 0.50, h = 0.50 },
	upper_left   = { x = 0.00, y = 0.00, w = 0.50, h = 0.50 },
	bottom_right = { x = 0.50, y = 0.50, w = 0.50, h = 0.50 },
	bottom_left  = { x = 0.00, y = 0.50, w = 0.50, h = 0.50 },
	center       = { x = 0.25, y = 0.25, w = 0.25, h = 0.25 },
}

M.right = function() hs.window.focusedWindow():move(units.right, nil, true) end
M.left = function() hs.window.focusedWindow():move(units.left, nil, true) end
M.top = function() hs.window.focusedWindow():move(units.top, nil, true) end
M.bot = function() hs.window.focusedWindow():move(units.bot, nil, true) end

M.upper_right = function() hs.window.focusedWindow():move(units.upper_right, nil, true) end
M.upper_left = function() hs.window.focusedWindow():move(units.upper_left, nil, true) end
M.bottom_right = function() hs.window.focusedWindow():move(units.bottom_right, nil, true) end
M.bottom_left = function() hs.window.focusedWindow():move(units.bottom_left, nil, true) end

return M
