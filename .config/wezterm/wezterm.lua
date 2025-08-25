local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Required on wayland
config.enable_wayland = false

-- --- Colours / Theming ---
config.colors = {
	foreground = "#e0e0e0",
	background = "#101010",

	selection_bg = "#323232",
	selection_fg = "#e0e0e0",

	cursor_bg = "#aeaeae",
	cursor_border = "#aeaeae",

	ansi = {
		"#080808", -- 0
		"#cf4f43", -- 1
		"#54964f", -- 2
		"#d17536", -- 3
		"#1b4666", -- 4
		"#5e196d", -- 5
		"#049191", -- 6
		"#646464", -- 7
	},
	brights = {
		"#323232", -- 8
		"#993e36", -- 9
		"#5c8b59", -- 10
		"#aa9c30", -- 11
		"#1267a5", -- 12
		"#8910ad", -- 13
		"#01a8a8", -- 14
		"#f5f5f5", -- 15
	},
}
-- config.color_scheme = "Quiet" -- This is quite a nice theme

config.bold_brightens_ansi_colors = false

-- --- Font ---
config.font = wezterm.font("FiraCode Nerd Font Mono")
config.font_size = 12.0

-- --- Window / UI ---
config.window_background_opacity = 0.90
config.hide_tab_bar_if_only_one_tab = true

config.window_close_confirmation = "NeverPrompt"

config.window_padding = {
	left = 10,
	right = 10,
	top = 8,
	bottom = 8,
}

return config
