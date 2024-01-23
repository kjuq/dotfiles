local wez = require("wezterm")

local C -- config
if wez.config_builder then
	C = wez.config_builder()
end

-- Startup with fullscreen
-- wez.on("gui-startup", function(cmd)
--     local _, _, window = wez.mux.spawn_window(cmd or {})
--     -- window:gui_window():maximize()
--     window:gui_window():toggle_fullscreen()
-- end)

C.color_scheme = "GruvboxDarkHard" -- "Catppuccin Mocha", "Tokyo Night", "iceberg-dark"

-- C.prefer_egl = false
C.max_fps = 250
C.front_end = "WebGpu"
C.webgpu_power_preference = "HighPerformance"

C.font = wez.font_with_fallback {
	"Hack Nerd Font",
	"Hiragino Sans",
	"SourceHanSansJP-Normal",     -- for linux, install `adobe-source-han-sans-jp-fonts`
}
C.freetype_load_target = "Normal" -- "Normal", "Light", "Mono"

C.window_background_opacity = 0.65

C.enable_tab_bar = false
C.window_decorations = "RESIZE"

C.disable_default_key_bindings = true
C.send_composed_key_when_left_alt_is_pressed = false
C.send_composed_key_when_right_alt_is_pressed = false

local key = function(key, mods, action)
	local table = {}
	table.key = key
	table.mods = mods
	table.action = action
	return table
end

C.keys = {
	key("c", "CMD", wez.action({ CopyTo = "Clipboard" })),
	key("Copy", "", wez.action({ CopyTo = "Clipboard" })),
	key("v", "CMD", wez.action({ PasteFrom = "Clipboard" })),
	key("Paste", "", wez.action({ PasteFrom = "Clipboard" })),
	key("f", "CMD|CTRL", wez.action.ToggleFullScreen),
	key("-", "CMD", wez.action.DecreaseFontSize),
	key("=", "CMD|SHIFT", wez.action.IncreaseFontSize),
	key("Backspace", "CMD", wez.action.SendKey({ key = "u", mods = "CTRL" })),
	key("Backspace", "CTRL", wez.action.SendKey({ key = "w", mods = "CTRL" })),
}

-- check os
if os.execute("[ $(uname) = 'Darwin' ]") then
	C.font_size = 19
elseif os.execute("[ $(uname) = 'Linux' ]") then
	C.font_size = 13
end

-- and finally, return the configuration to wezterm
return C
