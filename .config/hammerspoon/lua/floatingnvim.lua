local M = {}

---@type hs.task
local floatterm

local tmux = "/tmp/hammerspoon_tmux"
local inf_nvimcopy = "/tmp/hammerspoon_infinite_nvimcopy"

local create_executable_files = function()
	if not os.execute("test -e " .. tmux) then
		local file = io.open(tmux, "a")
		assert(file, "Unable to open file: " .. tmux)
		file:write("#!/usr/bin/env bash\n")
		file:write("tmux new-session /tmp/hammerspoon_infinite_nvimcopy\n")
		file:close()
		os.execute("chmod +x " .. tmux)
	end

	if not os.execute("test -e " .. inf_nvimcopy) then
		local file = io.open(inf_nvimcopy, "a")
		assert(file, "Unable to open file: " .. inf_nvimcopy)
		file:write("#!/usr/bin/env bash\n")
		file:write("while true; do\n")
		file:write("	~/.local/bin/nvimcopy\n")
		file:write("	hs -c 'hs.application.frontmostApplication():hide()'\n")
		file:write("	hs -c 'hs.eventtap.keyStroke({ \"cmd\" }, \"v\")'\n")
		file:write("done\n")
		file:close()
		os.execute("chmod +x " .. inf_nvimcopy)
	end
end

---@type function
---@return hs.task
local generate_floatterm = function()
	---@type hs.task
	floatterm = hs.task.new(
		"/opt/homebrew/bin/wezterm",
		nil,
		{
			"--config",
			"initial_rows=20",
			"--config",
			"initial_cols=80",
			"start",
			tmux,
		}
	)
	return floatterm
end

M.initialize = function()
	create_executable_files()
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
