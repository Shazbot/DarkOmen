PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS

local mission_key = "move_mission_to_kislev"

local payload = function(char)
	cm:callback(function()
		CampaignUI.ToggleCinematicBorders(true)
		cm:stop_user_input(true)
		cm:scroll_camera_from_current(true, 0.1, {441.19,507.90, 5, d_to_r(120), 4})  --x

		cm:callback(function()
			cm:move_to(cm:char_lookup_str(char), 644, 619, true) -- done
		end, 0.5)

		cm:scroll_camera_from_current(
			true, 4,
			{441.19,507.90, 5, d_to_r(120), 4},
			{437.84, 492.07, 5, d_to_r(120), 4}
		)

		cm:callback(function()
			CampaignUI.ToggleCinematicBorders(false)
			cm:stop_user_input(false)
			mod.set_state(mod.states.in_kraka_ravn_after_fimir_bog)
			cm:replenish_action_points(cm:char_lookup_str(char))
		end, 5)
	end, 0.1)
end

mod[mission_key] = {
	key = mission_key,
	ui_offsets = {725, 425},
	locs = {
		title="Kislev",
		desc="Kislev",
		mission_desc = "Kislev",
	},
	icon = "ui/small_city_schem_frame_major.png",
	payload = payload,
}