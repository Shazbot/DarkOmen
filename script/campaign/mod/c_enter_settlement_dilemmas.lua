PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS


---------------------------------------
---game_start--------------------------
--------------------------------------
core:remove_listener("Intro")
core:add_listener(
	"Intro",
	"pj_quests_on_state_changed",
	function(context)
		local state = context.string
		return state == mod.states.game_start
	end,
	function(context)
		cm:callback(function()
			cm:trigger_dilemma("wh2_main_dwf_karak_zorn", "Intro");
		end, 1)
	end,
	true
)
------------------------------------
--- after_move_mission_sjoktraken---
------------------------------------
core:remove_listener("after_move_mission_sjoktraken")
core:add_listener(
	"after_move_mission_sjoktraken",
	"pj_quests_on_state_changed",
	function(context)
		local state = context.string
		return state == mod.states.in_sjok
	end,
	function(context)
		cm:callback(function()
			cm:trigger_dilemma("wh2_main_dwf_karak_zorn", "after_move_mission_sjoktraken");
		end, 1)
	end,
	true
)
core:add_listener(
    "after_move_mission_sjoktraken_2",
    "DilemmaChoiceMadeEvent",
    true,
    function(context)
            if context:dilemma() == "after_move_mission_sjoktraken"
            then
                    if context:choice() == 0
                    then
                            cm:trigger_dilemma("wh2_main_dwf_karak_zorn", "after_move_mission_sjoktraken_2");
                    end;
                    if context:choice() == 1
                    then
                            cm:trigger_dilemma("wh2_main_dwf_karak_zorn", "after_move_mission_sjoktraken_2");
                    end;
            end;
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
	function(context)
		cm:callback(function()
			cm:trigger_dilemma("wh2_main_dwf_karak_zorn", "after_move_mission_sjoktraken_after_shipwreck");
		end, 1)
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
			cm:trigger_dilemma("wh2_main_dwf_karak_zorn", "after_move_mission_kraka_drak");
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
core:add_listener(
    "after_in_drak_after_beastmen_2",
    "DilemmaChoiceMadeEvent",
    true,
    function(context)
            if context:dilemma() == "after_in_drak_after_beastmen"
            then
                    if context:choice() == 0
                    then
                            cm:trigger_dilemma("wh2_main_dwf_karak_zorn", "after_in_drak_after_beastmen_2");
                    end;
                    if context:choice() == 1
                    then
                            cm:trigger_dilemma("wh2_main_dwf_karak_zorn", "after_in_drak_after_beastmen_2");
                    end;
            end;
    end,
    true
)