PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS

mod.states = {
	game_start = "game_start",
	in_sjok = "in_sjok",
	after_shipwreck = "after_shipwreck",
	after_last_inn = "after_last_inn",
	in_sjok_after_shipwreck = "in_sjok_after_shipwreck",
	in_sjok_after_last_inn = "in_sjok_after_last_inn",
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

		if cm:pending_battle_cache_num_attackers() >= 1 then
			for i = 1, cm:pending_battle_cache_num_attackers() do
				local this_char_cqi, _, current_faction_name = cm:pending_battle_cache_get_attacker(i);
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

	mod.missions = { -- takes names from the db' key (issued in "settlement" + qb name) for the move-destination for move missions
	-- Move missions --
		move_mission_sjoktraken = mod.move_mission_sjoktraken,
		move_mission_kraka_drak = mod.move_mission_kraka_drak,
		move_mission_kraka_ravnsvake = mod.move_mission_kraka_ravnsvake,
		move_mission_sjoktraken_after_shipwreck = mod.move_mission_sjoktraken_after_shipwreck,
		move_mission_sjoktraken_after_last_inn = mod.move_mission_sjoktraken_after_last_inn,
		move_mission_kraka_drak_after_beastmen = mod.move_mission_kraka_drak_after_beastmen,
	-- QB missions --
		mission_sjoktraken_shipwreck = mod.mission_sjoktraken_shipwreck,
		mission_sjoktraken_the_last_hope_inn = mod.mission_sjoktraken_the_last_hope_inn,
		mission_kraka_drak_beastmen_camp = mod.mission_kraka_drak_beastmen_camp,
		mission_kraka_drak_chaos_warp = mod.mission_kraka_drak_chaos_warp,
		mission_after_kraka_drak_mountain_pass = mod.mission_after_kraka_drak_mountain_pass,
		mission_kraka_ravnsvake_fimir_bog = mod.mission_kraka_ravnsvake_fimir_bog,
		mission_kraka_ravnsvake_icetrolls = mod.mission_kraka_ravnsvake_icetrolls,
	}

	mod.missions_list = { -- would like to have better names for these states
		game_start = {mod.move_mission_sjoktraken},
		in_sjok = {mod.mission_sjoktraken_shipwreck}, -- next line is curently filled to support testing, but not working
		-- after_shipwreck = {mod.move_mission_kraka_drak, mod.move_mission_kraka_ravnsvake, mod.mission_sjoktraken_the_last_hope_inn, mod.mission_kraka_drak_beastmen_camp, mod.mission_kraka_drak_chaos_warp, mod.mission_after_kraka_drak_mountain_pass, mod.mission_kraka_ravnsvake_fimir_bog, mod.mission_kraka_ravnsvake_icetrolls},
		after_shipwreck = {mod.move_mission_sjoktraken_after_shipwreck},
		in_sjok_after_shipwreck = {mod.move_mission_kraka_drak, mod.mission_sjoktraken_the_last_hope_inn},
		after_last_inn = {mod.move_mission_sjoktraken_after_last_inn},
		in_sjok_after_last_inn = {mod.move_mission_kraka_drak},
		in_kraka_drak = {mod.mission_kraka_drak_beastmen_camp},
		after_beastmen_camp = {mod.move_mission_kraka_drak_after_beastmen, mod.mission_kraka_drak_chaos_warp},
		in_drak_after_beastmen = {mod.mission_after_kraka_drak_mountain_pass,},
		in_drak_after_chaos = {}, -- no such state its a uicide mission
		after_chaos_warp = {}, -- no such state its a uicide mission
		in_kraka_ravn = {},
	}
end)
