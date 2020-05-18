PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS

local mission_key = "move_mission_to_kislev"

local payload = function(char)
	cm:callback(function()
		CampaignUI.ToggleCinematicBorders(true)
		cm:stop_user_input(true)
		cm:scroll_camera_from_current(true, 0.1, {437.8497, 492.077, 8, d_to_r(120), 4})

		cm:callback(function()
			cm:move_to(cm:char_lookup_str(char), 643, 625, true) -- moving to Kislev
		end, 0.5)

		cm:scroll_camera_from_current(
			true, 5.5,
			{431.165, 488.2179, 4, d_to_r(120), 4},
			{429.828, 482.8147, 4, d_to_r(120), 4}
		)

		cm:callback(function()
			CampaignUI.ToggleCinematicBorders(false)
			cm:stop_user_input(false)
			mod.set_state(mod.states.game_end)
		end, 7)
	end, 0.1)
end

mod[mission_key] = {
	key = mission_key,
	ui_offsets = {135, 505},
	locs = {
		title="Kislev",
		desc="Kislev",
		mission_desc = "Kislev",
	},
	icon = "ui/small_city_schem_frame_major.png",
	payload = payload,
}

-- this is the starting char and camera position
-- local char = cm:get_faction(cm:get_local_faction(true)):faction_leader()
-- cm:scroll_camera_from_current(true, 0.1, {437.8497, 492.077, 8, d_to_r(120), 4})
-- cm:teleport_to(cm:char_lookup_str(char), 655, 637, false)
