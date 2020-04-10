PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS

mod.mission_sjoktraken_the_last_hope_inn_payload = function(char)
	cm:callback(function()
		CampaignUI.ToggleCinematicBorders(true)
		cm:stop_user_input(true)
		cm:scroll_camera_from_current(true, 0.1, {464.588, 495.165, 5, d_to_r(120), 4})
		cm:callback(function()
			cm:callback(function()
				cm:move_to(cm:char_lookup_str(char), 679,635, true) -- mission_last_hope_inn
			end, 0.5)
			cm:scroll_camera_from_current(
				true, 4,
				{453.89309692383,490.53359985352, 5, d_to_r(120), 4}
			)

			-- after we finish moving enabled the UI and input and start the battle
			cm:callback(function()
				CampaignUI.ToggleCinematicBorders(false)
				cm:stop_user_input(false)
				mod.select_first_lord()
				cm:scroll_camera_from_current(true, 0.1, {453.89309692383,490.53359985352, 5, d_to_r(120), 4})
				mod.force_start_quest_battle("mission_sjoktraken_the_last_hope_inn")
			end, 5)

		end, 0.5)
	end, 0.1)
end

mod.mission_sjoktraken_the_last_hope_inn = {
	key = "mission_sjoktraken_the_last_hope_inn",
	ui_offsets = {725-40, 425+35+2-100},
	locs = {
		title="The Last Hope Inn",
		desc="The Last Hope Inn",
		mission_desc = "With the main passageways sourth being swamped with trolls and marauding raiders, the realm of the norse dwarfs have been isolated for decades with few tradeing options. A few minor routes still exist south to the men of Kislev, though they are rarely used. The tradeguild of Sjoktraken have requested our services, in a attempt to reopen the pass south to the Last Hope Inn, the most northern presence of the civilized men of the south. The Last Hope in is a few trade houses and a single Inn, which would have been burned down, where it not for its position high on the mountain side, only accessible by its lift.",
	},
	icon = "ui/small_icon_quest_battle.png",
	payload = mod.mission_sjoktraken_the_last_hope_inn_payload,
}

core:remove_listener("pj_quests_on_won_battle_the_last_hope_inn")
core:add_listener(
	"pj_quests_on_won_battle_the_last_hope_inn",
	"pj_quests_won_battle_the_last_hope_inn",
	true,
	function()
		mod.set_state(mod.states.after_shipwreck)
	end,
	true
)
