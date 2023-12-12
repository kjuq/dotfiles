-- Pull in the wezterm API
local wezterm = require("wezterm")

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
local config
if wezterm.config_builder then
	config = wezterm.config_builder() -- Start in capital letter to declare global var
end

-- Startup with fullscreen
-- wezterm.on('gui-startup', function(cmd)
--     local _, _, window = wezterm.mux.spawn_window(cmd or {})
--     -- window:gui_window():maximize()
--     window:gui_window():toggle_fullscreen()
-- end)

-- This table will hold the configuration.
config = {
	-- color_scheme = "Catppuccin Mocha",
	-- color_scheme = "Clone Of Ubuntu (Gogh)",
	-- color_scheme = "Gruvbox Dark (Gogh)",
	-- color_scheme = "GruvboxDarkHard",
	color_scheme = "Tokyo Night",
	-- color_scheme = "iceberg-dark",

	default_prog = {
		"/opt/homebrew/bin/fish",
		-- "--login",
		-- "--command",
		-- "tmux attach; or tmux",
	},

	window_background_opacity = 0.65,
	-- font = wezterm.font("Hack Nerd Font"),
	font = wezterm.font_with_fallback {
		"Hack Nerd Font",
		"Hiragino Sans",
		"SourceHanSansJP-Normal", -- for linux, install `adobe-source-han-sans-jp-fonts`
	},
	freetype_load_target = "Normal", -- "Normal", "Light", "Mono"

	enable_tab_bar = false,
	window_decorations = "RESIZE",
	disable_default_key_bindings = true,
	send_composed_key_when_left_alt_is_pressed = false,
	send_composed_key_when_right_alt_is_pressed = false,
	keys = {
		{
			key = "c",
			mods = "CMD",
			action = wezterm.action({ CopyTo = "Clipboard" }),
		},
		{
			key = "v",
			mods = "CMD",
			action = wezterm.action({ PasteFrom = "Clipboard" }),
		},
		{
			key = "f",
			mods = "CMD|CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
		{
			key = "-",
			mods = "CMD",
			action = wezterm.action.DecreaseFontSize,
		},
		{
			key = "=",
			mods = "CMD|SHIFT",
			action = wezterm.action.IncreaseFontSize,
		},
		{
			key = "Backspace",
			mods = "CMD",
			action = wezterm.action.SendKey({ key = "u", mods = "CTRL" }),
		},
	},
}

-- check os
if os.execute("[ $(uname) = 'Darwin' ]") then
	config.font_size = 20
elseif os.execute("[ $(uname) = 'Linux' ]") then
	config.font_size = 16
end

-- and finally, return the configuration to wezterm
return config
