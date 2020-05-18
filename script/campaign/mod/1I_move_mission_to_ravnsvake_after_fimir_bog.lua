PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS

local mission_key = "move_mission_to_ravnsvake_after_fimir_bog"

-- this is the starting char and camera position
-- local char = cm:get_faction(cm:get_local_faction(true)):faction_leader()
-- cm:scroll_camera_from_current(true, 0.1, {450.55, 490.92, 6, d_to_r(120), 4})
-- cm:teleport_to(cm:char_lookup_str(char), 671, 636, false)

local payload = function(char)
	cm:callback(function()
		CampaignUI.ToggleCinematicBorders(true)
		cm:stop_user_input(true)
		cm:scroll_camera_from_current(true, 0.1, {450.55, 490.92, 6, d_to_r(120), 4})

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
			cm:set_saved_value("pj_quests_fimir_bog_completed", true)
			mod.set_state(mod.states.in_kraka_ravn_after_fimir_bog)
			cm:replenish_action_points(cm:char_lookup_str(char))
		end, 5)
	end, 0.1)
end

mod[mission_key] = {
	key = mission_key,
	ui_offsets = {390, 330},
	locs = {
		title="After_fimir_bog",
		desc="After_fimir_bog",
		mission_desc = "After_fimir_bog",
	},
	icon = "ui/small_city_schem_frame_major.png",
	payload = payload,
}
