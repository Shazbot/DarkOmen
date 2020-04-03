PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS

mod.move_mission_sjoktraken_payload = function(char)
	-- add snow attrition immunity and add movement range
	local ceb = cm:create_new_custom_effect_bundle("wh2_main_encounter_at_sea_campaign_1")
	ceb:set_effect_value(ceb:effects():item_at(0), 500)
	ceb:set_duration(-1)
	cm:apply_custom_effect_bundle_to_characters_force(ceb, char)
	cm:apply_effect_bundle_to_characters_force("wh2_dlc11_bundle_immune_all_attrition", char:cqi(), -1, false)
	cm:replenish_action_points(cm:char_lookup_str(char))

	cm:teleport_to(cm:char_lookup_str(char), 710, 624, false)
	cm:callback(function()
		cm:move_to(cm:char_lookup_str(char), 709, 624, false)
	end, 0.5)
	cm:callback(function()
		CampaignUI.ToggleCinematicBorders(true)
		cm:stop_user_input(true)
		cm:scroll_camera_from_current(true, 0.01, {473.847, 480.216, 3, d_to_r(0), 3})
		cm:callback(function()
				cm:scroll_camera_from_current(true, 5, {474.847, 481.216, 5, d_to_r(120), 4})
		end, 0.5)
		cm:callback(function()
				cm:move_to(cm:char_lookup_str(char), 696, 635, true)
				cm:scroll_camera_from_current(true, 3, {465.257, 490.1476, 5, d_to_r(120), 4})
				cm:callback(function()
						CampaignUI.ToggleCinematicBorders(false)
						cm:stop_user_input(false)
						mod.set_state(mod.states.in_sjok)
						core:trigger_event("pj_quests_on_entered_sjoktraken")
				end, 4)
		end, 6.5)
	end, 1)
end

mod.move_mission_sjoktraken = {
	key = "move_mission_sjoktraken",
	ui_offsets = {725+103, 425+35+2-90-24},
	locs = {
		title="Move to Sjoktraken",
		desc="Trek To Sjoktraken",
		mission_desc = "Ironvein and his prospectors abandon the mines of Goromandny and head head towards Sjoktraken.",
	},
	icon = "ui/small_city_schem_frame_major.png",
	payload = mod.move_mission_sjoktraken_payload,
}
