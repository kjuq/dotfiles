local M = {}

---@type hs.task
local floatterm

---@type function
---@return hs.task
local generate_floatterm = function()
	---@type hs.task
	floatterm = hs.task.new("/opt/homebrew/bin/alacritty", nil, {
		"-o",
		"window.dimensions.lines=30",
		"-o",
		"window.dimensions.columns=100",
		"-o",
		"window.position.x=700",
		"-o",
		"window.position.y=500",
	})
	return floatterm
end

M.initialize = function()
	-- create_executable_files()
	floatterm = generate_floatterm():start()
end

M.toggle = function()
	if not floatterm then -- if floatterm is not running
		M.initialize()
		return
	end

	local app = hs.application.applicationForPID(floatterm:pid())
	if not app then
		M.initialize()
		return
	end

	if app:isFrontmost() then
		app:hide()
	else
		app:activate()
	end
end

return M
