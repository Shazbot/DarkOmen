-------------------------------------------------------------------------------------------------
------------------------------------------- KEY INFO --------------------------------------------
-------------------------------------------------------------------------------------------------
-- ReunitingLostKins
-- mission_sjoktraken_the_last_hope_inn
-- Attacker
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

------------------------------------------PLAYER--------------------------------------------------
ga_player = gb:get_army(gb:get_player_alliance_num(), 1, ""); -- player attacker 
------------------------------------------ALLY EMP---------------------------------------------------
ga_battle_the_last_hope_inn_character_name_emp_ally = gb:get_army(gb:get_player_alliance_num(),"battle_the_last_hope_inn_character_name_emp_ally"); -- Lord
ga_battle_the_last_hope_inn_army_emp_ally_huntsmen = gb:get_army(gb:get_player_alliance_num(),"battle_the_last_hope_inn_army_emp_ally_huntsmen"); -- Huntsmen
------------------------------------------ALLY DWF---------------------------------------------------
ga_battle_the_last_hope_inn_character_name_dwf_ally = gb:get_army(gb:get_player_alliance_num(),"battle_the_last_hope_inn_character_name_dwf_ally"); -- Lord
ga_battle_the_last_hope_inn_army_dwf_ally_wagon = gb:get_army(gb:get_player_alliance_num(),"battle_the_last_hope_inn_army_dwf_ally_wagon"); -- war wagon 
------------------------------------------ENEMY---------------------------------------------------
ga_battle_the_last_hope_inn_army_nor_unit_all = gb:get_army(gb:get_non_player_alliance_num(),"battle_the_last_hope_inn_army_nor_unit_all"); -- Lord/Spearmen/Berserkes/Chariot
------------------------------------------ENEMY REINFORCEMENT---------------------------------------------------
ga_battle_the_last_hope_inn_army_reinforcement_enemy_whole_army = gb:get_army(gb:get_non_player_alliance_num(),"battle_the_last_hope_inn_army_reinforcement_enemy_whole_army"); -- Reinforcement enemy army

-------------------------------------------------------------------------------------------------
------------------------------------------ OBJECTIVES -------------------------------------------
-------------------------------------------------------------------------------------------------
gb:set_objective_on_message("deployment_started", "mission_sjoktraken_the_last_hope_inn_objective_1_tooltip"); -- Liberate the Last Hope Inn
gb:set_objective_on_message("deployment_started", "mission_sjoktraken_the_last_hope_inn_objective_2_tooltip"); -- Pave the way for the Caravan

------------------------------------------FAIL---------------------------------------------------
ga_battle_the_last_hope_inn_army_dwf_ally_wagon:message_on_casualties("battle_the_last_hope_inn_army_dwf_ally_wagon_dying", 0.85); -- 0,85 casualties
gb:fail_objective_on_message("battle_the_last_hope_inn_army_dwf_ally_wagon_dying", "mission_sjoktraken_the_last_hope_inn_objective_2_tooltip", 5); -- fail: Wagon is destoyed "Pave the way for the Caravan"
ga_battle_the_last_hope_inn_army_nor_unit_all:force_victory_on_message("battle_the_last_hope_inn_army_dwf_ally_wagon_dying", 10000); -- force enemy victory

------------------------------------------WIN---------------------------------------------------
ga_battle_the_last_hope_inn_army_nor_unit_all:message_on_rout_proportion("battle_the_last_hope_inn_army_nor_unit_all_routing", 0.90); -- 0,90 dead or routing across enemy units and lords
ga_battle_the_last_hope_inn_army_nor_unit_all:rout_over_time_on_message("battle_the_last_hope_inn_army_nor_unit_all_routing",15000); -- Set the rest of the units to mass rout 15 sec
ga_player:force_victory_on_message("battle_the_last_hope_inn_army_nor_unit_all_routing", 20000); -- Player wins  20sec

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
---------------------------------------CUSTOM ORDERS----------------------------------------------
--------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------
---------------------------------------GENERAL BATTLE----------------------------------------------
--------------------------------------------------------------------------------------------------

------------------------------------------ENEMY DEFENDS-------------------------------------------
ga_battle_the_last_hope_inn_army_nor_unit_all:defend_on_message("deployment_started", -5.0, 100.0, 50); -- x/y radius

------------------------------------------PROXIMITY TRIGGER ATTACK-------------------------------------------
ga_player:message_on_proximity_to_enemy("proximity_to_enemy", 160); 
ga_battle_the_last_hope_inn_army_nor_unit_all:attack_on_message("proximity_to_enemy");

------------------------------------------ATTACK TRIGGER ATTACK-------------------------------------------
ga_battle_the_last_hope_inn_army_nor_unit_all:message_on_under_attack("under_attack");
ga_battle_the_last_hope_inn_army_nor_unit_all:attack_on_message("under_attack");

--------------------------------------------------------------------------------------------------
------------------------------------------ WAGON TO INN -------------------------------------------
--------------------------------------------------------------------------------------------------
ga_battle_the_last_hope_inn_army_dwf_ally_wagon:move_to_position_on_message("deployment_started", v(14, 96, -250)); -- needs a non range unit
ga_battle_the_last_hope_inn_army_dwf_ally_wagon:message_on_proximity_to_enemy("wagon_proximity_to_enemy", 160); -- halt when close to enemy
ga_battle_the_last_hope_inn_army_dwf_ally_wagon:defend_on_message("wagon_proximity_to_enemy", 5, 5, 10); -- halt when close to enemy

------------------------------------------ALLY EMP REINFORCE-------------------------------------------
ga_battle_the_last_hope_inn_character_name_emp_ally:reinforce_on_message("under_attack", 10000); -- reinforce from the last hop inn
ga_battle_the_last_hope_inn_army_emp_ally_huntsmen:reinforce_on_message("under_attack", 20000); -- reinforce from the last hop inn

-------------------------------------------------------------------------------------------------
---------------------------------------Enemy Reinforcement army ----------------------------------
-------------------------------------------------------------------------------------------------
ga_battle_the_last_hope_inn_army_reinforcement_enemy_whole_army:deploy_at_random_intervals_on_message("Wait_5min",1,2,60000,60000); -- after 5 min at intervals of 1 min 1-2 units joins the fight

-------------------------------------------------------------------------------------------------
--------------------------------------------- HINTS/MESSAGES ---------------------------------------------
-------------------------------------------------------------------------------------------------

gb:queue_help_on_message("battle_started", "mission_sjoktraken_the_last_hope_inn_objective_3_message", 8000, 2000, 1000); -- (Grunnar Vestgrud) "Break the Norsemen, to long have they tainted this Land"   
gb:queue_help_on_message("under_attack", "mission_sjoktraken_the_last_hope_inn_objective_4_message", 8000, 2000, 1000); -- (Grunnar Vestgrud) "The men of the Inn is with us!"  
