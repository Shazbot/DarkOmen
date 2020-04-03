PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS

mod.states = {
	game_start = "game_start",
	in_sjok = "in_sjok",
	after_shipwreck = "after_shipwreck",
	in_kraka_drak = "in_kraka_drak",
	in_kraka_ravn = "in_kraka_ravn",
	in_drak_after_beastmen = "in_drak_after_beastmen",
	in_drak_after_chaos = "in_drak_after_chaos",
	after_beastmen_camp = "after_beastmen_camp",
	after_chaos_warp = "after_chaos_warp",
}

mod.current_state = mod.current_state or mod.states.game_start

--- Listener for a custom event 'pj_quests_start_quest' that runs the payload associated with the  mission.
core:remove_listener("pj_quests_start_quest_cb")
core:add_listener(
	"pj_quests_start_quest_cb",
	"pj_quests_start_quest",
	function()
		return true
	end,
	function(context)
		local mission_key = context.string

		local char = cm:get_faction(cm:get_local_faction()):faction_leader()
		if mod.missions[mission_key] and mod.missions[mission_key].payload then
			mod.missions[mission_key].payload(char)
		end
	end,
	true
)

--- If we won a quest battle send out custom events.
--- For example for 'battle_shipwreck' we send 'pj_quests_won_battle_shipwreck' and 'pj_quests_lost_battle_shipwreck'.
core:remove_listener("pj_quests_check_qb_completed")
core:add_listener(
	"pj_quests_check_qb_completed",
	"BattleCompleted",
	true,
	function(context)
		local pb = cm:model():pending_battle();
		local battle_key = pb:set_piece_battle_key();

		if not battle_key then
			return
		end

		if cm:pending_battle_cache_num_defenders() >= 1 then
			for i = 1, cm:pending_battle_cache_num_defenders() do
				local this_char_cqi, _, current_faction_name = cm:pending_battle_cache_get_defender(i);
				if current_faction_name == cm:get_local_faction(true) then
					if not cm:model():character_for_command_queue_index(this_char_cqi):is_null_interface()
						and cm:model():character_for_command_queue_index(this_char_cqi):won_battle()
					then
						cm:callback(function() core:trigger_event("pj_quests_won_"..battle_key) end, 0.1)
					else
						cm:callback(function() core:trigger_event("pj_quests_lost_"..battle_key) end, 0.1)
					end
				end
			end
		end
	end,
	true
)

--- Set a new state.
mod.set_state = function(new_state)
	mod.current_state = new_state
	cm:set_saved_value("pj_quests_current_state", new_state);
	core:trigger_event("pj_quests_on_state_changed", new_state)
end

--- Get the state in the save file if there is one.
cm:add_first_tick_callback(function()
	mod.current_state = cm:get_saved_value("pj_quests_current_state") or mod.current_state

	mod.missions = {
		move_mission_sjoktraken = mod.move_mission_sjoktraken,
		mission_sjoktraken_shipwreck = mod.mission_sjoktraken_shipwreck,
		move_mission_kraka_drak = mod.move_mission_kraka_drak,
		mission_last_hope_inn = mod.mission_last_hope_inn,
	}

	mod.missions_list = {
		game_start = {mod.move_mission_sjoktraken},
		in_sjok = {mod.mission_sjoktraken_shipwreck},
		after_shipwreck = {mod.move_mission_kraka_drak, mod.mission_last_hope_inn},
		in_kraka_drak = {},
		in_kraka_ravn = {},
		in_drak_after_beastmen = {},
		in_drak_after_chaos = {},
		after_beastmen_camp = {},
		after_chaos_warp = {},
	}
end)
