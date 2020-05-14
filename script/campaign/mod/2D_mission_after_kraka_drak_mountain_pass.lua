PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS

local mission_key = "mission_after_kraka_drak_mountain_pass"

local payload = function(char)
	cm:callback(function()
		CampaignUI.ToggleCinematicBorders(true)
		cm:stop_user_input(true)
		cm:scroll_camera_from_current(true, 0.1, {455.23, 504.43, 5, d_to_r(120), 4})

		cm:callback(function()
			cm:move_to(cm:char_lookup_str(char), 660, 658, true) -- moving to the mountain pass
		end, 0.5)

		cm:scroll_camera_from_current(
			true, 4,
			{453.22, 510.21, 5, d_to_r(120), 4},
			{441.88, 507.61, 5, d_to_r(120), 4}
		)

		cm:callback(function()
			CampaignUI.ToggleCinematicBorders(false)
			cm:stop_user_input(false)
			mod.select_first_lord()
			mod.force_start_quest_battle("mission_after_kraka_drak_mountain_pass")
		end, 5)
	end, 0.1)
end

mod[mission_key] = {
	key = mission_key,
	ui_offsets = {390, 330},
	locs = {
		title="March to Kraka Ravnsvake",
		desc="March to Kraka Ravnsvake",
		mission_desc = "The underground route to Kraka Ravnsvake, has been swarming with foul monstrosities for some time now. Until cleansed by the tunnel patrols, its safer to take the surface route west of the main mountains. We will setup up camp beneath the Gruly pass and wait for calm weather, before crossing the mountain pass.",
	},
	icon = "ui/small_city_schem_frame_major.png",
	payload = payload,
}

core:remove_listener("pj_quests_on_won_battle_mountain_pass")
core:add_listener(
	"pj_quests_on_won_battle_mountain_pass",
	"pj_quests_won_battle_mountain_pass",
	true,
	function()
		mod.set_state(mod.states.after_mountain_pass_ambush)
	end,
	true
)
