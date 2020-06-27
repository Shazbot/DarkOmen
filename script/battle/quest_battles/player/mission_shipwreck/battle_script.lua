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
ga_player = gb:get_army(gb:get_player_alliance_num(), 2, ""); -- player defender
ga_battle_shipwreck_character_name_dwf_ally = gb:get_army(gb:get_player_alliance_num(),"battle_shipwreck_character_name_dwf_ally"); -- char/army
ga_battle_shipwreck_character_name_npc_ally = gb:get_army(gb:get_player_alliance_num(),"battle_shipwreck_character_name_npc_ally"); -- NPC ally
ga_battle_shipwreck_character_name_nor = gb:get_army(gb:get_non_player_alliance_num(),"battle_shipwreck_character_name_nor"); -- char/army
ga_battle_shipwreck_character_name_npc_enemy = gb:get_army(gb:get_non_player_alliance_num(),"battle_shipwreck_character_name_npc_enemy"); -- NPC enemy
ga_battle_shipwreck_army_dwf_ally_unit_hammers = gb:get_army(gb:get_player_alliance_num(),"battle_shipwreck_army_dwf_ally_unit_hammers"); -- units
ga_battle_shipwreck_army_dwf_ally_unit_rangers = gb:get_army(gb:get_player_alliance_num(),"battle_shipwreck_army_dwf_ally_unit_rangers"); -- units
ga_battle_shipwreck_army_npc_enemy_unit_war_mammoth = gb:get_army(gb:get_non_player_alliance_num(),"battle_shipwreck_army_npc_enemy_unit_war_mammoth"); -- NPC enemy unit mammoth
-------------------------------------------------------------------------------------------------
----------------------------------------- ARMY TELEPORT -----------------------------------------
-------------------------------------------------------------------------------------------------



-------------------------------------------------------------------------------------------------
------------------------------------------- CUTSCENE --------------------------------------------
-------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------
------------------------------------------ ORDERS -------------------------------------------
-------------------------------------------------------------------------------------------------
ga_battle_shipwreck_character_name_dwf_ally:message_on_shattered_proportion("battle_shipwreck_character_name_dwf_ally_dead", 1); -- Dead char
ga_battle_shipwreck_army_dwf_ally_unit_hammers:message_on_casualties("battle_shipwreck_army_dwf_ally_unit_hammers_dying", 0.95); -- 0,95 casualties
ga_battle_shipwreck_army_dwf_ally_unit_rangers:message_on_casualties("battle_shipwreck_army_dwf_ally_unit_rangers_dying", 0.95); -- 0,95 casualties

gb:fail_objective_on_message("battle_shipwreck_army_dwf_ally_unit_hammers_dying", "mission_shipwrecke_objective_1_tooltip", 5); -- Defend the Ironclad and its crew  
gb:fail_objective_on_message("battle_shipwreck_army_dwf_ally_unit_rangers_dying", "mission_shipwrecke_objective_1_tooltip", 5); -- Defend the Ironclad and its crew
gb:fail_objective_on_message("battle_shipwreck_character_name_dwf_ally_dead", "mission_shipwrecke_objective_2_tooltip", 5); -- Ensure the Master Engineer's survival

ga_battle_shipwreck_character_name_nor:force_victory_on_message("battle_shipwreck_army_dwf_ally_unit_hammers_dying", 10000); -- Fail: Defend the Ironclad and its crew  
ga_battle_shipwreck_character_name_nor:force_victory_on_message("battle_shipwreck_army_dwf_ally_unit_rangers_dying", 10000); -- Fail: Defend the Ironclad and its crew  
ga_battle_shipwreck_character_name_nor:force_victory_on_message("battle_shipwreck_character_name_dwf_ally_dead", 10000); -- Fail: Ensure the Master Engineer's survival

-- Ally Dwarfs defends--
ga_battle_shipwreck_character_name_dwf_ally:defend_on_message("battle_started", 251, -132, 50); -- x/y radius
ga_battle_shipwreck_army_dwf_ally_unit_hammers:defend_on_message("battle_started", 251, -132, 50); -- x/y radius
ga_battle_shipwreck_army_dwf_ally_unit_rangers:defend_on_message("battle_started", 251, -132, 50); -- x/y radius


---Dragon infight---
--works--ga_battle_shipwreck_character_name_npc_ally:attack_force_on_message("battle_started", ga_battle_shipwreck_character_name_npc_enemy,1000); --Ally dragon attack enemy dragon
--works--ga_battle_shipwreck_character_name_npc_enemy:attack_force_on_message("battle_started", ga_battle_shipwreck_character_name_npc_ally,1000); --Enemy dragon attack ally dragon
--works--ga_battle_shipwreck_character_name_npc_ally:teleport_to_start_location_offset_on_message("battle_started",200,200);
ga_battle_shipwreck_army_npc_enemy_unit_war_mammoth:teleport_to_start_location_offset_on_message("battle_started",200,25);
ga_battle_shipwreck_character_name_npc_ally:deploy_at_random_intervals_on_message("battle_started",1,1,5000,5000);
ga_battle_shipwreck_character_name_npc_ally:message_on_deployed("NPC_deployed")
ga_battle_shipwreck_character_name_npc_ally:attack_force_on_message("NPC_deployed", ga_battle_shipwreck_army_npc_enemy_unit_war_mammoth,1000);
-------------------------------------------------------------------------------------------------
------------------------------------------- OBJECTIVES ------------------------------------------
-------------------------------------------------------------------------------------------------

gb:set_objective_on_message("deployment_started", "mission_shipwrecke_objective_1_tooltip"); -- Defend the Ironclad and its crew  
gb:set_objective_on_message("deployment_started", "mission_shipwrecke_objective_2_tooltip"); -- Ensure the Master Engineer's survival

-------------------------------------------------------------------------------------------------
--------------------------------------------- HINTS/MESSAGES ---------------------------------------------
-------------------------------------------------------------------------------------------------

gb:queue_help_on_message("battle_started", "mission_shipwrecke_objective_3_message", 8000, 2000, 1000); -- (Grunnar Vestgrud) "Save our Brothers, Slay the Norsemen!"
gb:queue_help_on_message("battle_shipwreck_character_name_dwf_ally_dead", "mission_shipwrecke_objective_4_fail_message", 8000, 2000, 1000); -- The Crew is dead, all is lost. 
gb:queue_help_on_message("battle_shipwreck_army_dwf_ally_unit_hammers_dying", "mission_shipwrecke_objective_4_fail_message", 8000, 2000, 1000); -- The Crew is dead, all is lost. 
gb:queue_help_on_message("battle_shipwreck_army_dwf_ally_unit_rangers_dying", "mission_shipwrecke_objective_4_fail_message", 8000, 2000, 1000); -- The Crew is dead, all is lost. 
