local tmp = "/tmp/floatterm"
if not os.execute("test -e " .. tmp) then
	os.execute("echo '/opt/homebrew/bin/tmux new-session ~/.local/bin/nvimcopy' > " .. tmp)
	os.execute("chmod +x " .. tmp)
end

local M = {}

---@type hs.task
local floatterm
M.toggle = function()
	if floatterm ~= nil and floatterm:isRunning() then
		hs.application.applicationForPID(floatterm:pid()):activate()
		return
	end

	local generate_floatterm
	generate_floatterm = function()
		---@type hs.task
		floatterm = hs.task.new(
			"/opt/homebrew/bin/wezterm",
			function()
				hs.eventtap.keyStroke({ "cmd" }, "v")
				-- floatterm = generate_floatterm()
				-- floatterm:start()
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

	generate_floatterm():start()
end

return M
