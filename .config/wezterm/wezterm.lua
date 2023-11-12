-- Pull in the wezterm API
local wezterm = require("wezterm")

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	Config = wezterm.config_builder() -- Start in capital letter to declare global var
end

-- Startup with fullscreen
wezterm.on('gui-startup', function(cmd)
	local _, _, window = wezterm.mux.spawn_window(cmd or {})
	-- window:gui_window():maximize()
	window:gui_window():toggle_fullscreen()
end)

-- This table will hold the configuration.
Config = {
	-- color_scheme = "Catppuccin Mocha",
	-- color_scheme = "Clone Of Ubuntu (Gogh)",
	-- color_scheme = "Gruvbox Dark (Gogh)",
	-- color_scheme = "GruvboxDarkHard",
	color_scheme = "Tokyo Night",
	-- color_scheme = "iceberg-dark",

	window_background_opacity = 0.65,
	font_size = 16,
	font = wezterm.font("Hack Nerd Font"),
	freetype_load_target = "Normal", -- "Normal", "Light", "Mono"
	default_prog = {
		"/opt/homebrew/bin/fish",
		-- "--login",
		-- "--command",
		-- "tmux attach; or tmux",
	},
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
	},
}

-- and finally, return the configuration to wezterm
return Config
