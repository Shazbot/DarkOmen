PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS

------------------------------------
--- after_move_mission_sjoktraken---
------------------------------------
core:remove_listener("after_move_mission_sjoktraken_play_intro_event")
core:add_listener(
	"after_move_mission_sjoktraken_play_intro_event",
	"pj_quests_on_state_changed",
	function(context)
		local state = context.string
		return state == mod.states.in_sjok
	end,
	function()
		cm:callback(function()
			cm:repeat_callback(
				function()
					if not effect.is_any_movie_playing() then
						cm:callback(function()
							core:trigger_event("pj_quests_play_movie", "sjok_1")
						end, 0.1)
						cm:remove_callback("pj_quests_check_intro_movie_playing_cb")
					end
				end,
				0.1,
				"pj_quests_check_intro_movie_playing_cb"
			)

			cm:play_movie_in_ui("eventpics/chs/everchosen")
		end, 1)
	end,
	true
)

core:remove_listener("after_move_mission_sjoktraken_play_sjok_movie_1")
core:add_listener(
	"after_move_mission_sjoktraken_play_sjok_movie_1",
	"pj_quests_play_movie",
	function(context)
		return context.string == "sjok_1"
	end,
	function()
		cm:callback(function()
			cm:repeat_callback(
				function()
					if not effect.is_any_movie_playing() then
						cm:callback(function()
							core:trigger_event("pj_quests_on_after_event", "after_move_mission_sjoktraken")
						end, 0.1)
						cm:remove_callback("pj_quests_check_intro_movie_playing_cb")
					end
				end,
				0.1,
				"pj_quests_check_intro_movie_playing_cb"
			)

			cm:play_movie_in_ui("eventpics/chs/wh2_treasure_hunt_2")
		end, 1)
	end,
	true
)

core:remove_listener("after_move_mission_sjoktraken")
core:add_listener(
	"after_move_mission_sjoktraken",
	"pj_quests_on_after_event",
	function(context)
		return context.string == "after_move_mission_sjoktraken"
	end,
	function()
		cm:callback(function()
			cm:trigger_dilemma("wh2_main_dwf_karak_zorn", "after_move_mission_sjoktraken");
		end, 1)
	end,
	true
)

core:add_listener(
    "after_move_mission_sjoktraken_2",
    "DilemmaChoiceMadeEvent",
		function(context)
			return context:dilemma() == "after_move_mission_sjoktraken"
		end,
		function(context)
			local choice = context:choice()
			cm:callback(function()
				cm:repeat_callback(
					function()
						if not effect.is_any_movie_playing() then
							cm:callback(function()
								if choice == 0
								then
												cm:trigger_dilemma("wh2_main_dwf_karak_zorn", "after_move_mission_sjoktraken_2");
								end;
								if choice == 1
								then
												cm:trigger_dilemma("wh2_main_dwf_karak_zorn", "after_move_mission_sjoktraken_2");
								end
							end, 0.1)
							cm:remove_callback("pj_quests_check_intro_movie_playing_cb")
						end
					end,
					0.1,
					"pj_quests_check_intro_movie_playing_cb"
				)

				cm:play_movie_in_ui("eventpics/chs/wh2_treasure_hunt_3")
			end, 0.5)
    end,
    true
)
----------------------------------------------------
--- after_shipwreck (battle)------------------------
----------------------------------------------------
core:remove_listener("after_mission_shipwreck")
core:add_listener(
	"after_mission_shipwreck",
	"pj_quests_on_state_changed",
	function(context)
		local state = context.string
		return state == mod.states.after_shipwreck
	end,
	function(context)
		cm:callback(function()
			cm:trigger_dilemma("wh2_main_dwf_karak_zorn", "after_mission_shipwreck");
		end, 1)
	end,
	true
)
----------------------------------------------------
--- after_move_mission_sjoktraken_after_shipwreck---
----------------------------------------------------
core:remove_listener("after_move_mission_sjoktraken_after_shipwreck")
core:add_listener(
	"after_move_mission_sjoktraken_after_shipwreck",
	"pj_quests_on_state_changed",
	function(context)
		local state = context.string
		return state == mod.states.in_sjok_after_shipwreck
	end,
	function()
		cm:callback(function()
			mod.play_rite()
			cm:callback(function()
				mod.open_contract_complete_panel(
					5000,
					function()
						cm:trigger_dilemma("wh2_main_dwf_karak_zorn", "after_move_mission_sjoktraken_after_shipwreck")
					end
				)
			end, 4.5)
		end, 0.7)
	end,
	true
)
----------------------------------------------------
---after_last_inn (batlle)--------------------------
----------------------------------------------------
core:remove_listener("after_mission_last_inn")
core:add_listener(
	"after_mission_last_inn",
	"pj_quests_on_state_changed",
	function(context)
		local state = context.string
		return state == mod.states.after_last_inn
	end,
	function(context)
		cm:callback(function()
			cm:trigger_dilemma("wh2_main_dwf_karak_zorn", "after_mission_last_inn");
		end, 1)
	end,
	true
)
----------------------------------------------------
--- after_move_mission_sjoktraken_after_last_inn---
-----------------------------------------------------
core:remove_listener("after_move_mission_sjoktraken_after_last_inn")
core:add_listener(
	"after_move_mission_sjoktraken_after_last_inn",
	"pj_quests_on_state_changed",
	function(context)
		local state = context.string
		return state == mod.states.in_sjok_after_last_inn
	end,
	function(context)
		cm:callback(function()
			cm:trigger_dilemma("wh2_main_dwf_karak_zorn", "after_move_mission_sjoktraken_after_last_inn");
		end, 1)
	end,
	true
)
---------------------------------------------------
--- In Kraka Drak ---------------------------------
---------------------------------------------------
core:remove_listener("in_kraka_drak")
core:add_listener(
	"in_kraka_drak",
	"pj_quests_on_state_changed",
	function(context)
		local state = context.string
		return state == mod.states.in_kraka_drak
	end,
	function(context)
		cm:callback(function()
			cm:repeat_callback(
				function()
					if not effect.is_any_movie_playing() then
						cm:callback(function()
							cm:trigger_dilemma("wh2_main_dwf_karak_zorn", "after_move_mission_kraka_drak");
						end, 0.1)
						cm:remove_callback("pj_quests_check_intro_movie_playing_cb")
					end
				end,
				0.1,
				"pj_quests_check_intro_movie_playing_cb"
			)

			cm:play_movie_in_ui("eventpics/chs/wh2_treasure_hunt_4")
		end, 1)
	end,
	true
)
core:add_listener(
    "after_move_mission_kraka_drak_2",
    "DilemmaChoiceMadeEvent",
    true,
    function(context)
            if context:dilemma() == "after_move_mission_kraka_drak"
            then
                    if context:choice() == 0
                    then
                            cm:trigger_dilemma("wh2_main_dwf_karak_zorn", "after_move_mission_kraka_drak_2");
                    end;
                    if context:choice() == 1
                    then
                            cm:trigger_dilemma("wh2_main_dwf_karak_zorn", "after_move_mission_kraka_drak_2");
                    end;
            end;
    end,
    true
)
----------------------------------------------------
---after_beastmen_camp (battle)---------------------
----------------------------------------------------
core:remove_listener("after_mission_beastmen_camp")
core:add_listener(
	"after_mission_beastmen_camp",
	"pj_quests_on_state_changed",
	function(context)
		local state = context.string
		return state == mod.states.after_beastmen_camp
	end,
	function(context)
		cm:callback(function()
			cm:trigger_dilemma("wh2_main_dwf_karak_zorn", "after_mission_beastmen_camp");
		end, 1)
	end,
	true
)
----------------------------------------------------------------
--- Kraka Drak after beastmen ---------------------------------
---------------------------------------------------------------
core:remove_listener("after_in_drak_after_beastmen")
core:add_listener(
	"after_in_drak_after_beastmen",
	"pj_quests_on_state_changed",
	function(context)
		local state = context.string
		return state == mod.states.in_drak_after_beastmen
	end,
	function(context)
		cm:callback(function()
			cm:trigger_dilemma("wh2_main_dwf_karak_zorn", "after_in_drak_after_beastmen");
		end, 1)
	end,
	true
)
----------------------------------------------------------------
--- after skaven ambush (battle) ---------------------------------
---------------------------------------------------------------
core:remove_listener("after_mountain_pass_ambush")
core:add_listener(
	"after_mountain_pass_ambush",
	"pj_quests_on_state_changed",
	function(context)
		local state = context.string
		return state == mod.states.after_mountain_pass_ambush
	end,
	function(context)
		cm:callback(function()
			cm:trigger_dilemma("wh2_main_dwf_karak_zorn", "after_mountain_pass_ambush");
		end, 1)
	end,
	true
)
----------------------------------------------------------------
--- in_kraka_ravn ---------------------------------
---------------------------------------------------------------
core:remove_listener("in_kraka_ravn")
core:add_listener(
	"in_kraka_ravn",
	"pj_quests_on_state_changed",
	function(context)
		local state = context.string
		return state == mod.states.in_kraka_ravn
	end,
	function(context)
		cm:callback(function()
			cm:trigger_dilemma("wh2_main_dwf_karak_zorn", "in_kraka_ravn");
		end, 1)
	end,
	true
)
----------------------------------------------------------------
--- after_ice_trolls ---------------------------------
---------------------------------------------------------------
core:remove_listener("after_ice_trolls")
core:add_listener(
	"after_ice_trolls",
	"pj_quests_on_state_changed",
	function(context)
		local state = context.string
		return state == mod.states.after_ice_trolls
	end,
	function(context)
		cm:callback(function()
			cm:trigger_dilemma("wh2_main_dwf_karak_zorn", "after_ice_trolls");
		end, 1)
	end,
	true
)
----------------------------------------------------------------
--- after_fimir_bog ---------------------------------
---------------------------------------------------------------
core:remove_listener("after_fimir_bog")
core:add_listener(
	"after_fimir_bog",
	"pj_quests_on_state_changed",
	function(context)
		local state = context.string
		return state == mod.states.after_fimir_bog
	end,
	function(context)
		cm:callback(function()
			cm:trigger_dilemma("wh2_main_dwf_karak_zorn", "after_fimir_bog");
		end, 1)
	end,
	true
)
----------------------------------------------------------------
--- in_kraka_ravn_after_ice_trolls ---------------------------------
---------------------------------------------------------------
core:remove_listener("in_kraka_ravn_after_ice_trolls")
core:add_listener(
	"in_kraka_ravn_after_ice_trolls",
	"pj_quests_on_state_changed",
	function(context)
		local state = context.string
		return state == mod.states.in_kraka_ravn_after_ice_trolls
	end,
	function(context)
		cm:callback(function()
			cm:trigger_dilemma("wh2_main_dwf_karak_zorn", "in_kraka_ravn_after_ice_trolls");
		end, 1)
	end,
	true
)
----------------------------------------------------------------
--- in_kraka_ravn_after_fimir_bog ---------------------------------
---------------------------------------------------------------
core:remove_listener("in_kraka_ravn_after_fimir_bog")
core:add_listener(
	"in_kraka_ravn_after_fimir_bog",
	"pj_quests_on_state_changed",
	function(context)
		local state = context.string
		return state == mod.states.in_kraka_ravn_after_fimir_bog
	end,
	function(context)
		cm:callback(function()
			cm:trigger_dilemma("wh2_main_dwf_karak_zorn", "in_kraka_ravn_after_fimir_bog");
		end, 1)
	end,
	true
)
----------------------------------------------------------------
--- END  ---------------------------------
---------------------------------------------------------------
core:remove_listener("Game_End")
core:add_listener(
	"Game_End",
	"pj_quests_on_state_changed",
	function(context)
		local state = context.string
		return state == mod.states.game_end
	end,
	function(context)
		cm:callback(function()
			cm:trigger_dilemma("wh2_main_dwf_karak_zorn", "game_end");
		end, 1)
	end,
	true
)
