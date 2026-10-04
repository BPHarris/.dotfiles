---@diagnostic disable: undefined-global, lowercase-global

-- TODO (hyprlang to lua migration)
-- Toggle swallow
-- Re-think keybinds
-- Test on laptop
-- These @type directives
-- Refactor key binds

mod = "SUPER"

local cursor_size = 24
local gtk_theme = "Orchis-Black-Green-Dark-Compact"
local qt_theme = "qt5ct" -- Note: "qt5ct" for default, "gtk3" to try to copy GTK theme
local qt_widget_style = "kvantum"
local icon_theme = "Luv"

terminal = {
	spawn = "foot",
	spawn_client = "footclient",
}
dmenu = {
	name = "fuzzel",
	spawn = "fuzzel --icon-theme=" .. icon_theme,
	kill = "pkill fuzzel",
}
bar = {
	name = "waybar",
	spawn = "waybar",
	kill = "pkill waybar",
}
emoji_picker = "rofimoji --selector " .. dmenu.name .. " --action print type copy"

hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1,
})

-- XDG/Wayland env vars
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/#xdg-specifications
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")

-- Theming
-- Note: wiki says you might not want XCURSOR_SIZE
hl.env("XCURSOR_SIZE", cursor_size)
hl.env("ICON_THEME", icon_theme)
hl.env("GTK_THEME", gtk_theme)
hl.env("QT_STYLE_OVERRIDE", qt_widget_style)
hl.env("QT_QPA_PLATFORMTHEME", qt_theme)

-- Use Wayland by default with X11 fallback
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/#toolkit-backend-variables
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")

-- SDL2 Audio fix
-- Also see #toolkit-backend-variables
hl.env("SDL_VIDEODRIVER", "wayland")

-- Auto-start
hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd --all")
	hl.exec_cmd(
		"systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP HYPRLAND_INSTANCE_SIGNATURE XDG_SESSION_TYPE"
	)

	hl.exec_cmd("/usr/lib/xdg-desktop-portal-hyprland")
	hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")

	-- systemd managed auto-start
	hl.exec_cmd("systemctl --user start hyprland-session.target")

	hl.exec_cmd(bar.spawn)
	hl.exec_cmd("mako")
	hl.exec_cmd("blueman-applet")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("hypridle")

	-- Foot server must be running for ``footclient`` to work
	hl.exec_cmd("foot --server")
end)

hl.config({
	general = {
		border_size = 1,

		gaps_in = 4,
		gaps_out = 8,

		col = {
			inactive_border = 0xff080808,
			active_border = 0xffe0e0e0,
		},

		layout = "master",

		resize_on_border = true,

		allow_tearing = false,

		locale = "en_GB",

		snap = {
			enabled = true,
			border_overlap = true,
			respect_gaps = true,
		},
	},

	decoration = {
		rounding = 4,

		dim_inactive = true,
		dim_strength = 0.1,
		dim_special = 0.1,

		blur = {
			enabled = true,
			size = 1,
			passes = 2,
		},

		shadow = {
			enabled = true,
			range = 8,
			render_power = 2,
			color = 0xff080808,
		},

		glow = {
			enabled = false,
		},
	},

	animations = {
		enabled = true,
	},

	input = {
		kb_layout = "gb",
		kb_options = "caps:swapescape",

		sensitivity = 0.3,
		accel_profile = "flat",

		-- Trackpad two-finger scroll
		scroll_method = "2fg",

		follow_mouse = 2,
		focus_on_close = 2,

		-- See "XPS Trackpad" device settings below
		touchpad = {
			disable_while_typing = true,
			natural_scroll = true,
		},
	},

	gestures = {
		workspace_swipe_forever = true,
	},

	group = {},

	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,

		font_family = "FiraCode Nerd Font Mono:style=Regular:size=14",

		force_default_wallpaper = 0,

		vrr = 2,

		enable_swallow = true,
		swallow_regex = "^(Alacritty|alacritty|com\\.mitchellh\\.ghostty|org\\.wezfurlong\\.wezterm|foot|footclient)$",

		focus_on_activate = true,

		on_focus_under_fullscreen = 2,
		initial_workspace_tracking = 1,

		middle_click_paste = false,
	},

	binds = {
		hide_special_on_workspace_change = true,
		allow_workspace_cycles = true,
	},

	render = {
		direct_scanout = 2,
	},

	cursor = {
		no_warps = true,
		warp_on_change_workspace = 2,
		warp_on_toggle_special = 2,
	},

	ecosystem = {
		no_donation_nag = true,
	},

	master = {
		mfact = 0.5,
		new_status = "master",
		smart_resizing = false,
	},
})

-- Enable blur on waybar
hl.layer_rule({
	match = { namespace = bar.name },
	blur = true,
})

-- XPS Trackpad
hl.device({
	name = "dll0945:00-06cb:cde6-touchpad",
	accel_profile = "adaptive",
	sensitivity = 0.2,
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

-- Animations
require("modules.animations")

-- Tweaks
require("modules.smartgaps")

-- Scratch pads
-- Note: Keybinds depends on scratchpads being declared first
require("modules.scratchpads")

-- Keybinds
require("modules.keybinds")
