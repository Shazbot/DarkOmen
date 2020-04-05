PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS

mod.move_mission_kraka_drak_payload = function(char)
	cm:callback(function()
		CampaignUI.ToggleCinematicBorders(true)
		cm:stop_user_input(true)
		cm:scroll_camera_from_current(true, 0.01, {456.56698608398,505.19943237305, 3, d_to_r(0), 3})
		cm:callback(function()
				cm:scroll_camera_from_current(true, 5, {474.847, 481.216, 5, d_to_r(120), 4})
		end, 0.5)
		cm:callback(function()
				cm:move_to(cm:char_lookup_str(char), 696, 635, true) -- sjoktraken
				cm:scroll_camera_from_current(true, 3, {456.56698608398,505.19943237305, 5, d_to_r(120), 4})
				cm:callback(function()
						CampaignUI.ToggleCinematicBorders(false)
						cm:stop_user_input(false)
						mod.set_state(mod.states.in_sjok)
						core:trigger_event("pj_quests_on_entered_sjoktraken")
				end, 4)
		end, 6.5)
	end, 1)
end

mod.move_mission_kraka_drak = {
	key = "move_mission_kraka_drak",
	ui_offsets = {725, 425+35+2-90-24},
	locs = {
		title="March to Kraka Drak",
		desc="March to Kraka Drak",
		mission_desc = "By royal request, we are to march towards Kraka Drak. We will march to the mountains and enter the underway pathways. ",
	},
	icon = "ui/small_city_schem_frame_major.png",
	payload = mod.move_mission_kraka_drak_payload,
}
