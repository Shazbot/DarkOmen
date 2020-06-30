PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS

mod.mission_sjoktraken_shipwreck_payload = function(char)
	cm:callback(function()
		CampaignUI.ToggleCinematicBorders(true)
		cm:stop_user_input(true)
		cm:scroll_camera_from_current(true, 0.01, {464.257, 490.1476, 6, d_to_r(120), 3})
		cm:callback(function()
			cm:move_to(cm:char_lookup_str(char), 704,649, true) -- mission shipwreck
			cm:scroll_camera_from_current(true, 3, {470.60491943359,500.95404052734, 5, d_to_r(120), 4})
			cm:callback(function()
				CampaignUI.ToggleCinematicBorders(false)
				cm:stop_user_input(false)
				mod.select_first_lord()
				cm:scroll_camera_from_current(true, 0.1, {470.60491943359,500.95404052734, 5, d_to_r(120), 4})

				local custom_bundle = cm:create_new_custom_effect_bundle("pj_quests_empty_1")
				custom_bundle:add_effect("wh2_dlc13_effect_wulfhart_battle_army_abilities", "faction_to_force_own", 1)
				cm:apply_custom_effect_bundle_to_faction(custom_bundle, cm:get_faction(cm:get_local_faction(true)))

				mod.force_start_quest_battle("mission_sjoktraken_shipwreck")
			end, 4)
		end, 0.1)
	end, 0.1)
end

mod.mission_sjoktraken_shipwreck = {
	key = "mission_sjoktraken_shipwreck",
	ui_offsets = {528, 253},
	parchment_text_offset = {-31, 0},
	locs = {
		title="The Last of the Northern Ironclads ",
		desc="The Last of the Northern Ironclads",
		mission_desc = "The sea routes between Sjoktraken and the minor ports of the northerns holds are used to fortify and supply the realm. The last of the Ironclads, gifted by the high King og Barak Var ages ago, have gone missing. The port master of Sjoktraken, Thorin Seabborn have approached us, ininquiring our service. We are to travel two days north by the Draksfjord and search for the missing Ironclad and by any means secure it.",
	},
	icon = "ui/small_icon_quest_battle.png",
	payload = mod.mission_sjoktraken_shipwreck_payload,
}

core:remove_listener("pj_quests_on_won_battle_shipwreck")
core:add_listener(
	"pj_quests_on_won_battle_shipwreck",
	"pj_quests_won_battle_shipwreck",
	true,
	function()
		mod.set_state(mod.states.after_shipwreck)
	end,
	true
)

core:remove_listener("pj_quests_on_won_battle_shipwreck_remove_ironclad_cannon")
core:add_listener(
	"pj_quests_on_won_battle_shipwreck_remove_ironclad_cannon",
	"pj_quests_won_battle_shipwreck",
	true,
	function()
		cm:remove_effect_bundle("pj_quests_empty_1", cm:get_local_faction(true))
	end,
	true
)

core:remove_listener("pj_quests_on_lost_battle_shipwreck_remove_ironclad_cannon")
core:add_listener(
	"pj_quests_on_lost_battle_shipwreck_remove_ironclad_cannon",
	"pj_quests_lost_battle_shipwreck",
	true,
	function()
		cm:remove_effect_bundle("pj_quests_empty_1", cm:get_local_faction(true))
	end,
	true
)
