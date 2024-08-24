local wez = require('wezterm')

local C -- config
if wez.config_builder then
	C = wez.config_builder()
end

-- Appearance {{{

C.color_scheme = 'Kanagawa (Gogh)' -- "GruvboxDarkHard", "Catppuccin Mocha", "Tokyo Night", "iceberg-dark"

C.colors = {
	background = 'black',
	cursor_fg = 'black',
	visual_bell = '#303030',
}

C.window_background_opacity = 0.65
C.window_decorations = 'RESIZE'
C.enable_tab_bar = false

-- }}}

-- Options {{{

C.max_fps = 250
C.front_end = 'WebGpu'
C.webgpu_power_preference = 'HighPerformance'

C.audible_bell = 'Disabled' -- or 'SystemBeep'

local duration = 60
C.visual_bell = {
	fade_in_function = 'EaseIn',
	fade_in_duration_ms = duration,
	fade_out_function = 'EaseOut',
	fade_out_duration_ms = duration,
}

-- }}}

-- Fonts {{{

local fonts = {}

---@param font table|string
local add_font = function(font)
	---@type string
	local fontname
	if type(font) == 'string' then
		fontname = font
	elseif type(font) == 'table' then
		fontname = font.family
	end

	local cmd = os.getenv('SHELL') .. " -c 'fc-list --quiet " .. fontname .. "'"
	if os.execute(cmd) then
		table.insert(fonts, font)
	end
end

add_font('CozetteVector')
add_font('PixelMplus12')
add_font('HackNerdFont')
add_font('Menlo') -- MacOS`s builtin
add_font('Hiragino Sans') -- MacOS's builtin Japanese font
add_font('SourceHanSansJP-Normal') -- Japanese font for linux, install `adobe-source-han-sans-jp-fonts`
add_font('NotoColorEmoji') -- Emoji font `noto-fonts-emoji`

C.font = wez.font_with_fallback(fonts)

-- C.freetype_load_target = 'Normal' -- "Normal", "Light", "Mono"
-- C.freetype_load_flags = 'NO_HINTING'

--- }}}

-- Keymaps {{{

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
	key('c', 'CMD', wez.action({ CopyTo = 'Clipboard' })),
	key('Copy', '', wez.action({ CopyTo = 'Clipboard' })),
	key('v', 'CMD', wez.action({ PasteFrom = 'Clipboard' })),
	key('Paste', '', wez.action({ PasteFrom = 'Clipboard' })),

	key('f', 'CMD|CTRL', wez.action.ToggleFullScreen),
	key('q', 'CMD', wez.action.QuitApplication),

	key('-', 'CMD', wez.action.DecreaseFontSize),
	key('=', 'CMD|SHIFT', wez.action.IncreaseFontSize), -- TODO: not working
	key('=', 'CMD', wez.action.ResetFontSize),

	key('Backspace', 'CMD', wez.action.SendKey({ key = 'u', mods = 'CTRL' })),
	key('Backspace', 'CTRL', wez.action.SendKey({ key = 'w', mods = 'CTRL' })),

	key('F18', '', wez.action.Nop),
	key('F19', '', wez.action.Nop),
	key('F20', '', wez.action.Nop),
}

-- }}}

-- Device specific configurations {{{

if os.execute("[ $(uname) = 'Darwin' ]") then
	C.font_size = 22
elseif os.execute("[ $(uname --nodename) = 'KSGO' ]") then
	C.font_size = 24
elseif os.execute("[ $(uname --nodename) = 'KANTC' ]") then
	C.font_size = 16
elseif os.execute("[ $(uname --nodename) = 'KOXPX' ]") then
	C.font_size = 16
end

--- }}}

-- and finally, return the configuration to wezterm
return C
