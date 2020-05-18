PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS

local mission_key = "move_mission_to_ravnsvake_after_ice_trolls"

-- this is the starting char and camera position
-- local char = cm:get_faction(cm:get_local_faction(true)):faction_leader()
-- cm:scroll_camera_from_current(true, 0.1, {429.828, 486.674, 5, d_to_r(120), 4})
-- cm:teleport_to(cm:char_lookup_str(char), 643, 630, false)

local payload = function(char)
	cm:callback(function()
		CampaignUI.ToggleCinematicBorders(true)
		cm:stop_user_input(true)
		cm:scroll_camera_from_current(true, 0.1, {429.828, 486.674, 5, d_to_r(120), 4})

		cm:callback(function()
			cm:move_to(cm:char_lookup_str(char), 655, 637, true)
		end, 0.5)

		cm:scroll_camera_from_current(
			true, 4,
			{437.8497, 492.077, 8, d_to_r(120), 4}
		)

		cm:callback(function()
			CampaignUI.ToggleCinematicBorders(false)
			cm:stop_user_input(false)
			cm:set_saved_value("pj_quests_ice_trolls_completed", true)
			mod.set_state(mod.states.in_kraka_ravn_after_ice_trolls)
			cm:replenish_action_points(cm:char_lookup_str(char))
		end, 5)
	end, 0.1)
end

mod[mission_key] = {
	key = mission_key,
	ui_offsets = {555, 505},
	locs = {
		title="After ice_trolls",
		desc="After ice_trolls",
		mission_desc = "After ice_trolls",
	},
	icon = "ui/small_city_schem_frame_major.png",
	payload = payload,
}
