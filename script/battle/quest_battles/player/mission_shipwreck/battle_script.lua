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
gc:add_element(nil, nil, "gc_orbit_90_medium_commander_back_close_low_01", 16000, true, false, false);

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

------------------------------------------PLAYER---------------------------------------------------
ga_player = gb:get_army(gb:get_player_alliance_num(), 2, ""); -- defender
------------------------------------------ALLY---------------------------------------------------
ga_battle_shipwreck_character_name_dwf_ally = gb:get_army(gb:get_player_alliance_num(),"battle_shipwreck_character_name_dwf_ally"); -- Master engineer
ga_battle_shipwreck_army_dwf_ally_unit_hammers = gb:get_army(gb:get_player_alliance_num(),"battle_shipwreck_army_dwf_ally_unit_hammers"); -- Hammers
ga_battle_shipwreck_army_dwf_ally_unit_rangers = gb:get_army(gb:get_player_alliance_num(),"battle_shipwreck_army_dwf_ally_unit_rangers"); -- Rangers
------------------------------------------DRAGON---------------------------------------------------
ga_battle_shipwreck_character_name_npc_ally = gb:get_army(gb:get_player_alliance_num(),"battle_shipwreck_character_name_npc_ally"); -- Dragon
------------------------------------------ENEMY---------------------------------------------------
ga_battle_shipwreck_army_nor_unit_all = gb:get_army(gb:get_non_player_alliance_num(),"battle_shipwreck_army_nor_unit_all"); --2x chaos_warhounds + 2x marauder_berserkers
ga_battle_shipwreck_character_name_nor_1 = gb:get_army(gb:get_non_player_alliance_num(),"battle_shipwreck_character_name_nor_1");-- Lord of mammoth
ga_battle_shipwreck_army_nor_1_unit_war_mammoth = gb:get_army(gb:get_non_player_alliance_num(),"battle_shipwreck_army_nor_1_unit_war_mammoth"); -- Mammoth in own script group
------------------------------------------ENEMY REINFORCEMENT---------------------------------------------------
ga_battle_shipwreck_character_name_reinforcement_enemy_whole_army = gb:get_army(gb:get_non_player_alliance_num(),"battle_shipwreck_character_name_reinforcement_enemy_whole_army"); -- Reinforcement enemy army 

-------------------------------------------------------------------------------------------------
------------------------------------------ OBJECTIVES -------------------------------------------
-------------------------------------------------------------------------------------------------
gb:set_objective_on_message("deployment_started", "mission_shipwrecke_objective_1_tooltip"); -- Defend the Ironclad and its crew  
gb:set_objective_on_message("deployment_started", "mission_shipwrecke_objective_2_tooltip"); -- Ensure the Master Engineer's survival

------------------------------------------FAIL---------------------------------------------------
ga_battle_shipwreck_character_name_dwf_ally:message_on_shattered_proportion("battle_shipwreck_character_name_dwf_ally_dead", 1); -- Dead char
ga_battle_shipwreck_army_dwf_ally_unit_hammers:message_on_casualties("battle_shipwreck_army_dwf_ally_unit_hammers_dying", 0.95); -- 0,95 casualties
ga_battle_shipwreck_army_dwf_ally_unit_rangers:message_on_casualties("battle_shipwreck_army_dwf_ally_unit_rangers_dying", 0.95); -- 0,95 casualties

gb:fail_objective_on_message("battle_shipwreck_army_dwf_ally_unit_hammers_dying", "mission_shipwrecke_objective_1_tooltip", 5); -- Defend the Ironclad and its crew  
gb:fail_objective_on_message("battle_shipwreck_army_dwf_ally_unit_rangers_dying", "mission_shipwrecke_objective_1_tooltip", 5); -- Defend the Ironclad and its crew
gb:fail_objective_on_message("battle_shipwreck_character_name_dwf_ally_dead", "mission_shipwrecke_objective_2_tooltip", 5); -- Ensure the Master Engineer's survival

ga_battle_shipwreck_army_nor_unit_all:force_victory_on_message("battle_shipwreck_army_dwf_ally_unit_hammers_dying", 10000); -- Fail: Defend the Ironclad and its crew  
ga_battle_shipwreck_army_nor_unit_all:force_victory_on_message("battle_shipwreck_army_dwf_ally_unit_rangers_dying", 10000); -- Fail: Defend the Ironclad and its crew  
ga_battle_shipwreck_army_nor_unit_all:force_victory_on_message("battle_shipwreck_character_name_dwf_ally_dead", 10000); -- Fail: Ensure the Master Engineer's survival

------------------------------------------WIN---------------------------------------------------
ga_battle_shipwreck_army_nor_unit_all:message_on_rout_proportion("battle_shipwreck_army_nor_unit_all_routing", 0.85); -- 0,85 dead or routing across enemy units and lords
ga_battle_shipwreck_army_nor_unit_all:rout_over_time_on_message("battle_shipwreck_army_nor_unit_all_routing",15000); -- Set the rest of the units to mass rout 15 sec
ga_player:force_victory_on_message("battle_shipwreck_army_nor_unit_all_routing", 20000); -- Player wins  20sec
-------------------------------------------------------------------------------------------------
-- ------------------------------------ALLY DEFENDS-----------------------------------------------
--------------------------------------------------------------------------------------------------
ga_battle_shipwreck_character_name_dwf_ally:defend_on_message("battle_started", 251, -132, 50); -- x/y radius
ga_battle_shipwreck_army_dwf_ally_unit_hammers:defend_on_message("battle_started", 251, -132, 50); -- x/y radius
ga_battle_shipwreck_army_dwf_ally_unit_rangers:defend_on_message("battle_started", 251, -132, 50); -- x/y radius

-------------------------------------------------------------------------------------------------
--------------------------------- TIME KEEPER FROM BATTLE START --------------------------------
-------------------------------------------------------------------------------------------------

gb:message_on_time_offset("Wait_1min",60000);
gb:message_on_time_offset("Wait_2min",120000);
gb:message_on_time_offset("Wait_3min",180000);
gb:message_on_time_offset("Wait_4min",240000);
gb:message_on_time_offset("Wait_5min",300000);
gb:message_on_time_offset("Wait_6min",360000);
gb:message_on_time_offset("Wait_7min",420000);
gb:message_on_time_offset("Wait_8min",480000);
gb:message_on_time_offset("Wait_9min",540000);
gb:message_on_time_offset("Wait_10min",600000);
gb:message_on_time_offset("Wait_11min",660000);
gb:message_on_time_offset("Wait_12min",720000);
gb:message_on_time_offset("Wait_13min",780000);
gb:message_on_time_offset("Wait_14min",840000);
gb:message_on_time_offset("Wait_15min",900000);
gb:message_on_time_offset("Wait_16min",960000);
gb:message_on_time_offset("Wait_17min",1020000);
gb:message_on_time_offset("Wait_18min",1080000);
gb:message_on_time_offset("Wait_19min",1140000);
gb:message_on_time_offset("Wait_20min",1200000);

-------------------------------------------------------------------------------------------------
------------------------------------------ DRAGON/MAMMOTH INFIGHT------------------------------------
-------------------------------------------------------------------------------------------------
-- TP mammoth and lord to position and holds (mammoth pen on map) ---- Waits 1 min and deploys Dragon. ---- Dragon attacks mammoth (and lord) --
-- Dragon on map is noted by the player with a measege   ---- Lord flee on proxi to dragon, mammoth flees after fighting and at 50%hp with.
-- Auto flee tied to the dragon to prevent it from joining in-- 

-- Dragon and mammoth infight---
ga_battle_shipwreck_army_nor_1_unit_war_mammoth:teleport_to_start_location_offset_on_message("battle_started",200,25);-- tp at deployment
ga_battle_shipwreck_character_name_npc_ally:deploy_at_random_intervals_on_message("Wait_1min",1,1,6000,6000); -- after 1 min dragon deploys
ga_battle_shipwreck_character_name_npc_ally:message_on_deployed("NPC_deployed"); -- meassage on dragon deployment
gb:queue_help_on_message("NPC_deployed", "mission_shipwrecke_objective_5_message", 8000, 2000, 1000); -- "A Dragon! Carefull it is here to hunt"
ga_battle_shipwreck_character_name_npc_ally:attack_force_on_message("NPC_deployed", ga_battle_shipwreck_army_nor_1_unit_war_mammoth,1000); -- dragon attack mammoth
ga_battle_shipwreck_army_nor_1_unit_war_mammoth:message_on_casualties("mammoth_flee",0.5); -- mammoth has 50% hp left
ga_battle_shipwreck_army_nor_1_unit_war_mammoth:rout_over_time_on_message("mammoth_flee",5000);  -- mammoth starts fleeing
ga_battle_shipwreck_character_name_npc_ally:rout_over_time_on_message("mammoth_flee",15000); -- Dragon "flees" as well

-- Accompanying lord flee on sight--
ga_battle_shipwreck_character_name_nor_1:teleport_to_start_location_offset_on_message("battle_started",200,26); -- tp at deployment
ga_battle_shipwreck_character_name_nor_1:message_on_proximity_to_enemy("Dragon_here",20); -- dragon is close
ga_battle_shipwreck_character_name_nor_1:rout_over_time_on_message("Dragon_here",1000); -- Lord Flees

-------------------------------------------------------------------------------------------------
---------------------------------Enemy Reinforcement army --------------------------------
-------------------------------------------------------------------------------------------------
-- Start 5 mins in, with a 1 to 1 mins between reinforcements chunks of 1-2
ga_battle_shipwreck_character_name_reinforcement_enemy_whole_army:deploy_at_random_intervals_on_message("Wait_5min",1,2,60000,60000); -- after 5 min at intervals of 1 min 1-2 units joins the fight

-------------------------------------------------------------------------------------------------
--------------------------------------------- HINTS/MESSAGES ---------------------------------------------
-------------------------------------------------------------------------------------------------

gb:queue_help_on_message("battle_started", "mission_shipwrecke_objective_3_message", 8000, 2000, 1000); -- (Grunnar Vestgrud) "Save our Brothers, Slay the Norsemen!"
gb:queue_help_on_message("battle_shipwreck_character_name_dwf_ally_dead", "mission_shipwrecke_objective_4_fail_message", 8000, 2000, 1000); -- The Crew is dead, all is lost. 
gb:queue_help_on_message("battle_shipwreck_army_dwf_ally_unit_hammers_dying", "mission_shipwrecke_objective_4_fail_message", 8000, 2000, 1000); -- The Crew is dead, all is lost. 
gb:queue_help_on_message("battle_shipwreck_army_dwf_ally_unit_rangers_dying", "mission_shipwrecke_objective_4_fail_message", 8000, 2000, 1000); -- The Crew is dead, all is lost. 
