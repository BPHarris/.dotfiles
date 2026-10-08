---@diagnostic disable: undefined-global, lowercase-global

-- Spawns
hl.bind(mod .. " + Return", hl.dsp.exec_cmd(terminal.spawn))
hl.bind(mod .. " + P", hl.dsp.exec_cmd(dmenu.kill .. " || " .. dmenu.spawn))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(emoji_picker))
hl.bind(mod .. " + O", hl.dsp.exec_cmd(terminal.spawn_client .. " opencode"))

-- WM controls
hl.bind(mod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mod .. " + SHIFT + R", hl.dsp.exec_cmd(bar.kill .. " ; " .. bar.spawn))
hl.bind(mod .. " + SHIFT + ALT + Q", hl.dsp.exit())

hl.bind(mod .. " + SHIFT + L", hl.dsp.exec_cmd("loginctl lock-session"))
-- hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd("wlogout -b 4"))
hl.bind(mod .. " + ALT + H", hl.dsp.exec_cmd("systemctl hibernate"))

hl.bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle" }))

hl.bind(mod .. " + J", hl.dsp.layout("cyclenext"), { repeating = true })
hl.bind(mod .. " + K", hl.dsp.layout("cycleprev"), { repeating = true })
hl.bind(mod .. " + H", hl.dsp.layout("mfact -0.05"))
hl.bind(mod .. " + L", hl.dsp.layout("mfact +0.05"))

hl.bind(mod .. " + left", hl.dsp.focus({ direction = "left" }), { repeating = true })
hl.bind(mod .. " + up", hl.dsp.focus({ direction = "up" }), { repeating = true })
hl.bind(mod .. " + down", hl.dsp.focus({ direction = "down" }), { repeating = true })
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "right" }), { repeating = true })

-- WM controls: master layout
hl.bind(mod .. " + Space", hl.dsp.layout("swapwithmaster ignoremaster"))

hl.bind(mod .. " + ALT + J", hl.dsp.layout("rollprev"))
hl.bind(mod .. " + ALT + K", hl.dsp.layout("rollnext"))

hl.bind(mod .. " + SHIFT + Space", hl.dsp.layout("orientationcycle left top center"), { repeating = true })
hl.bind(mod .. " + ALT + C", hl.dsp.layout("orientationcenter"))
hl.bind(mod .. " + ALT + L", hl.dsp.layout("orientationleft"))
hl.bind(mod .. " + ALT + R", hl.dsp.layout("orientationright"))
hl.bind(mod .. " + ALT + T", hl.dsp.layout("orientationtop"))
hl.bind(mod .. " + ALT + B", hl.dsp.layout("orientationbottom"))

-- WM controls: workspaces
for i = 1, 10 do
	local key = i % 10
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mod .. " + Tab", hl.dsp.focus({ workspace = "previous" }))

-- Screenshots
local screenshot_path = [[$(xdg-user-dir PICTURES)/screenshots/$(date -u "+%Y-%m-%dT%H-%M-%S.png")]]

hl.bind("SHIFT + Print", hl.dsp.exec_cmd("grimblast copysave screen " .. screenshot_path))
hl.bind("Print", hl.dsp.exec_cmd("grimblast copysave area " .. screenshot_path))
hl.bind(
	"CTRL + Print",
	hl.dsp.exec_cmd("grimblast save area - | swappy -f - --output-file - | tee " .. screenshot_path .. " | wl-copy")
)

-- Scratch pads
hl.bind(mod .. " + SHIFT + S", hl.dsp.workspace.toggle_special("scratchpad_terminal"))
hl.bind(mod .. " + SHIFT + H", hl.dsp.workspace.toggle_special("scratchpad_htop"))
hl.bind(mod .. " + SHIFT + B", hl.dsp.workspace.toggle_special("scratchpad_btop"))
hl.bind(mod .. " + SHIFT + K", hl.dsp.workspace.toggle_special("scratchpad_keepassxc"))

------------------------
---- MEDIA CONTROLS ----
------------------------

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"))

------------------------
---- MOUSE CONTROLS ----
------------------------

hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
