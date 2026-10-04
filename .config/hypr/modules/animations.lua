---@diagnostic disable: undefined-global, lowercase-global

hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.025 } } })
hl.curve("subtle_overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.015 } } })

-- Window create / close
hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "overshot" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "overshot" })

-- Border colour change
hl.animation({ leaf = "border", enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 5, bezier = "default" })

-- Opacity change
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "default" })

-- Switch workspaces
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "subtle_overshot" })

-- Show special workspace / scratchpad
hl.animation({
	leaf = "specialWorkspace",
	enabled = true,
	speed = 3,
	bezier = "subtle_overshot",
	style = "slidefadevert +50%",
})

-- Pop-ups, launcher, etc.
hl.animation({ leaf = "layersIn", enabled = true, speed = 2, bezier = "default" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1, bezier = "default" })
