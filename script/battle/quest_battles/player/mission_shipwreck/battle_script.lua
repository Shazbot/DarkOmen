-------------------------------------------------------------------------------------------------
------------------------------------------- KEY INFO --------------------------------------------
-------------------------------------------------------------------------------------------------
-- ReunitingLostKins
-- mission_shipwreck
-- Defender
-------------------------------------------------------------------------------------------------
------------------------------------------- PRELOADS --------------------------------------------
-------------------------------------------------------------------------------------------------
load_script_libraries();
bm = battle_manager:new(empire_battle:new());

local gc = generated_cutscene:new(true);

--generated_cutscene:add_element(sfx_name, subtitle, camera, min_length, wait_for_vo, wait_for_camera, loop_camera)
gc:add_element(nil, "nil", "qb_final_position", 6000, false, true, false);

gb = generated_battle:new(
	true,                                     			-- screen starts black
	false,                                     			-- prevent deployment for player
	false,                                    			-- prevent deployment for ai
	function() gb:start_generated_cutscene(gc) end, 	-- intro cutscene function
	false                                      			-- debug mode
);

gb:set_cutscene_during_deployment(true);

-------------------------------------------------------------------------------------------------
---------------------------------------- INTRO VO & SUBS ----------------------------------------
-------------------------------------------------------------------------------------------------



-------------------------------------------------------------------------------------------------
------------------------------------------ ARMY SETUP -------------------------------------------
-------------------------------------------------------------------------------------------------
ga_attacker_01 = gb:get_army(gb:get_player_alliance_num(), 1, "");
ga_dwarf_1 = gb:get_army(gb:get_player_alliance_num(),"battle_shipwreck_dwf_ally");
ga_nor_1 = gb:get_army(gb:get_non_player_alliance_num(),"battle_shipwreck_nor");

-------------------------------------------------------------------------------------------------
----------------------------------------- ARMY TELEPORT -----------------------------------------
-------------------------------------------------------------------------------------------------



-------------------------------------------------------------------------------------------------
------------------------------------------- CUTSCENE --------------------------------------------
-------------------------------------------------------------------------------------------------



-------------------------------------------------------------------------------------------------
------------------------------------------ ORDERS -------------------------------------------
-------------------------------------------------------------------------------------------------
ga_dwarf_1:message_on_casualties("dwarf_1_dying", 0.5);
ga_dwarf_1:message_on_shattered_proportion("dwarf_1_dead", 1);

ga_nor_1:message_on_casualties("nor_1_dying", 0.5);
ga_nor_1:message_on_shattered_proportion("nor_1_dead", 1);

ga_dwarf_1:release_on_message("battle_started");

gb:complete_objective_on_message("nor_1_dead", "mission_shipwrecke_objective_4_fail_message", 5);
gb:fail_objective_on_message("dwarf_1_dying", "mission_shipwrecke_objective_4_fail_message", 5);

-------------------------------------------------------------------------------------------------
------------------------------------------- OBJECTIVES ------------------------------------------
-------------------------------------------------------------------------------------------------

gb:set_objective_on_message("deployment_started", "mission_shipwrecke_objective_1_tooltip");
gb:set_objective_on_message("deployment_started", "mission_shipwrecke_objective_2_tooltip");

-------------------------------------------------------------------------------------------------
--------------------------------------------- HINTS/MESSAGES ---------------------------------------------
-------------------------------------------------------------------------------------------------

gb:queue_help_on_message("battle_started", "mission_shipwrecke_objective_3_message", 8000, 2000, 1000);

