PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS

local mission_key = "move_mission_to_ravnsvake_after_ambush"

local payload = function(char)
	cm:callback(function()
		CampaignUI.ToggleCinematicBorders(true)
		cm:stop_user_input(true)
		cm:scroll_camera_from_current(true, 0.1, {441.88, 507.61, 5, d_to_r(120), 4})

		cm:callback(function()
			cm:move_to(cm:char_lookup_str(char), 655, 637, true) -- moving to krak ravn
		end, 0.5)

		cm:scroll_camera_from_current(
			true, 7.5,
			{435.1758, 504.4275, 7, d_to_r(120), 4},
			{437.8497, 492.077, 8, d_to_r(120), 4}
		)

		cm:callback(function()
			CampaignUI.ToggleCinematicBorders(false)
			cm:stop_user_input(false)
			mod.set_state(mod.states.in_kraka_ravn)
		end, 8)
	end, 0.1)
end

mod[mission_key] = {
	key = mission_key,
	ui_offsets = {390, 330},
	locs = {
		title="After ambush",
		desc="After ambush",
		mission_desc = "After ambush",
	},
	icon = "ui/small_city_schem_frame_major.png",
	payload = payload,
}

-- this is the starting char and camera position
-- local char = cm:get_faction(cm:get_local_faction(true)):faction_leader()
-- cm:scroll_camera_from_current(true, 0.1, {441.88, 507.61, 4, d_to_r(120), 4})
-- cm:teleport_to(cm:char_lookup_str(char), 660, 658, false)
