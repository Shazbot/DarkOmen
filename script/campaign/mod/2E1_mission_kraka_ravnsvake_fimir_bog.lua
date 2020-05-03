PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS

local mission_key = "mission_kraka_ravnsvake_fimir_bog"

local payload = function(char)
	cm:callback(function()
		CampaignUI.ToggleCinematicBorders(true)
		cm:stop_user_input(true)
		cm:scroll_camera_from_current(true, 0.1, {455.23, 504.43, 5, d_to_r(120), 4})

		cm:callback(function()
			cm:move_to(cm:char_lookup_str(char), 671, 636, true) 
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
			mod.force_start_quest_battle("mission_kraka_ravnsvake_fimir_bog")
		end, 5)
	end, 0.1)
end

mod[mission_key] = {
	key = mission_key,
	ui_offsets = {725-117+40, 425-257-60},
	locs = {
		title="Hunting Grounds",
		desc="Hunting Grounds",
		mission_desc = "Kraka Ravnsvake's commander of arms and high armour to the keep, Jorin Asserbo, is looking for able warriors to join a assault on a Fimir Bog. The Bog lies 2 days to the east, in one of Kraka Ravnsvake important hunting grounds. While a priority to the commander, more pressing matters have taken his attention, why he is looking for sellswords, that can handle the task.Two full retinues of rangers will accompany the assault, while their safe return to the garrison will be rewarded as well.",
	},
	icon = "ui/small_city_schem_frame_major.png",
	payload = payload,
}

core:remove_listener("pj_quests_on_won_battle_fimir_bog")
core:add_listener(
	"pj_quests_on_won_battle_fimir_bogs",
	"pj_quests_won_battle_fimir_bog",
	true,
	function()
		mod.set_state(mod.states.after_fimir_bog)
	end,
	true
)