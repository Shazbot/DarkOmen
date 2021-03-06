PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS

local mission_key = "move_mission_sjoktraken_after_last_inn"

local payload = function(char)
	cm:callback(function()
		CampaignUI.ToggleCinematicBorders(true)
		cm:stop_user_input(true)
		cm:scroll_camera_from_current(true, 0.1, {453.89,490.53, 5, d_to_r(120), 4}) -- reset the camera to a starting position

		cm:callback(function()
			cm:callback(function()
				cm:move_to(cm:char_lookup_str(char), 694, 638, true) -- moving to the front of sjoktraken
			end, 0.5)

			cm:scroll_camera_from_current(
				true, 4,
				{463.92, 492.46, 5, d_to_r(120), 4}
			)

			-- after we finish moving enabled the UI and input and start the battle
			cm:callback(function()
				CampaignUI.ToggleCinematicBorders(false)
				cm:stop_user_input(false)
				mod.set_state(mod.states.in_sjok_after_last_inn)
				cm:replenish_action_points(cm:char_lookup_str(char))
			end, 5)
		end, 0.5)
	end, 0.1)
end

mod[mission_key] = {
	key = mission_key,
	ui_offsets = {502, 309},
	locs = {
		title="Return to Sjoktraken",
		desc="Return to Sjoktraken",
		mission_desc = "The inhabitants of the Last Hope Inn and the envoy to the merchant guild celebrated they renewed contact by forging trade agreements. Four decades had passed since a dwarf last time visited the Inn. Stocked up on exotic goods from the southern lands of Kislev, we are to escort the merchants back to Sjoktraken.",
	},
	icon = "ui/small_city_schem_frame_major.png",
	payload = payload,
}
