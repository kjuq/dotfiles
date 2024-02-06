local M = {}

---@type hs.task
local floatterm

---@type function
---@return hs.task
local generate_floatterm

local tmp = "/tmp/floatterm"

local create_init_cmds = function()
	if not os.execute("test -e " .. tmp) then
		os.execute("echo '/opt/homebrew/bin/tmux new-session ~/.local/bin/nvimcopy' > " .. tmp)
		os.execute("chmod +x " .. tmp)
	end
end

local open_floatterm_then_hide = function()
	floatterm = generate_floatterm():start()
	os.execute("sleep 1")
	hs.application.applicationForPID(floatterm:pid()):hide()
end

generate_floatterm = function()
	---@type hs.task
	floatterm = hs.task.new(
		"/opt/homebrew/bin/wezterm",
		function()
			hs.eventtap.keyStroke({ "cmd" }, "v")
			open_floatterm_then_hide()
		end,
		{
			"--config",
			"initial_rows=1",
			"--config",
			"initial_cols=1",
			"start",
			"--position",
			"main:100%,0",
			tmp,
		}
	)
	return floatterm
end

M.toggle = function()
	if floatterm ~= nil and floatterm:isRunning() then
		---@type hs.application
		local app = hs.application.applicationForPID(floatterm:pid())
		app:activate()
		require("lua.snap").center()
		-- hs.window.focusedWindow():maximize()
		return
	end
	generate_floatterm():start()
end

M.initialize = function()
	create_init_cmds()
	open_floatterm_then_hide()
end

return M
