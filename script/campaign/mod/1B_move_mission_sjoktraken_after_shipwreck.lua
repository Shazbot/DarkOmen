PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS

-- for debugging
-- local char = cm:get_faction(cm:get_local_faction()):faction_leader()
-- cm:teleport_to(cm:char_lookup_str(char), 704,649, false) -- start position at shipwreck battle for testing
-- cm:teleport_to(cm:char_lookup_str(char), 695, 641, false) -- final position at sjok for testing

mod.move_mission_sjoktraken_after_shipwreck_payload = function(char)
	cm:callback(function()
		CampaignUI.ToggleCinematicBorders(true)
		cm:stop_user_input(true)
		cm:scroll_camera_from_current(true, 0.1, {470.60, 500.95, 5, d_to_r(120), 4})
		cm:callback(function()
			cm:move_to(cm:char_lookup_str(char), 695, 641, true) -- sjoktraken
			cm:scroll_camera_from_current(true, 2.5, {464.58, 495.16, 5, d_to_r(120), 4})
			cm:callback(function()
					CampaignUI.ToggleCinematicBorders(false)
					cm:stop_user_input(false)
					mod.set_state(mod.states.in_sjok_after_shipwreck)
					cm:replenish_action_points(cm:char_lookup_str(char))
			end, 3)
		end, 0.1)
	end, 0.1)
end

mod.move_mission_sjoktraken_after_shipwreck = {
	key = "move_mission_sjoktraken_after_shipwreck",
	ui_offsets = {725+103, 425+35+2-90-24},
	locs = {
		title="March to Sjoktraken",
		desc="March to Sjoktraken",
		mission_desc = "Ensure the Ironclads returnto Sjoktracken.",
	},
	icon = "ui/small_city_schem_frame_major.png",
	payload = mod.move_mission_sjoktraken_after_shipwreck_payload,
}
