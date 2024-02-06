-- https://qiita.com/haruyama480/items/bf9e6a42fedbdbbaf438

local duration = 0.05
local delta = 25

local M = {}

M.down = function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	f.y = f.y + delta
	win:setFrameInScreenBounds(f, duration)
end

M.up = function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	f.y = f.y - delta
	win:setFrameInScreenBounds(f, duration)
end

M.left = function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	f.x = f.x - delta
	win:setFrameInScreenBounds(f, duration)
end

M.right = function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	f.x = f.x + delta
	win:setFrameInScreenBounds(f, duration)
end

return M
