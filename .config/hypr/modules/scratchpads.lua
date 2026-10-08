---@diagnostic disable: undefined-global, lowercase-global

function create_centred_scratchpad(name, cmd)
	hl.workspace_rule({
		workspace = "special:" .. name,
		on_created_empty = cmd,
		gaps_out = 150,
	})
end

create_centred_scratchpad("scratchpad_terminal", "[stayfocused]" .. terminal.spawn)
create_centred_scratchpad("scratchpad_htop", terminal.spawn_client .. " htop")
create_centred_scratchpad("scratchpad_btop", terminal.spawn_client .. " btop")
create_centred_scratchpad("scratchpad_keepassxc", "keepassxc")
