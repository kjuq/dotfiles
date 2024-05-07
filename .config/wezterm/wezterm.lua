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

C.color_scheme = "Kanagawa (Gogh)" -- "GruvboxDarkHard", "Catppuccin Mocha", "Tokyo Night", "iceberg-dark"

C.colors = {
	background = "black",
	cursor_fg = "black",
}

-- C.prefer_egl = false
C.max_fps = 250
C.front_end = "WebGpu"
C.webgpu_power_preference = "HighPerformance"

local fonts = {}

local add_font = function(fontname)
	local cmd = os.getenv("SHELL") .. " -c 'fc-list --quiet " .. fontname .. "'"
	if os.execute(cmd) then
		table.insert(fonts, fontname)
	end
end

add_font("CozetteVector")
add_font("PixelMplus12")
add_font("Menlo")
add_font("Hiragino Sans") -- MacOS's builtin
add_font("SourceHanSansJP-Normal") -- for linux, install `adobe-source-han-sans-jp-fonts`

C.font = wez.font_with_fallback(fonts)

C.freetype_load_target = "Normal" -- "Normal", "Light", "Mono"

C.window_background_opacity = 0.65

C.audible_bell = "Disabled"

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
	key("q", "CMD", wez.action.QuitApplication),

	key("-", "CMD", wez.action.DecreaseFontSize),
	key("=", "CMD|SHIFT", wez.action.IncreaseFontSize),
	key("=", "CMD", wez.action.ResetFontSize),

	key("Backspace", "CMD", wez.action.SendKey({ key = "u", mods = "CTRL" })),
	key("Backspace", "CTRL", wez.action.SendKey({ key = "w", mods = "CTRL" })),

	key("F18", "", wez.action.Nop),
	key("F19", "", wez.action.Nop),
	key("F20", "", wez.action.Nop),
}

-- check os
if os.execute("[ $(uname) = 'Darwin' ]") then
	C.font_size = 22
elseif os.execute("[ $(uname) = 'Linux' ]") then
	C.font_size = 14
end

-- and finally, return the configuration to wezterm
return C
