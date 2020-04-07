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
ga_player = gb:get_army(gb:get_player_alliance_num(), 1, ""); -- player attacker 

ga_battle_the_last_hope_inn_character_name_emp_ally = gb:get_army(gb:get_player_alliance_num(),"battle_the_last_hope_inn_character_name_emp_ally"); -- char/army
ga_battle_the_last_hope_inn_army_emp_ally_huntsmen = gb:get_army(gb:get_player_alliance_num(),"battle_the_last_hope_inn_army_emp_ally_huntsmen"); -- units

ga_battle_the_last_hope_inn_character_name_nor = gb:get_army(gb:get_non_player_alliance_num(),"battle_the_last_hope_inn_character_name_nor"); -- char/army
ga_battle_the_last_hope_inn_army_nor_unit_marauder_spearman = gb:get_army(gb:get_non_player_alliance_num(),"battle_the_last_hope_inn_army_nor_unit_marauder_spearman"); -- units
ga_battle_the_last_hope_inn_army_nor_unit_marauder_warwolves_chariot = gb:get_army(gb:get_non_player_alliance_num(),"battle_the_last_hope_inn_army_nor_unit_marauder_warwolves_chariot"); -- units
ga_battle_the_last_hope_inn_army_nor_unit_marauder_berserkers = gb:get_army(gb:get_non_player_alliance_num(),"battle_the_last_hope_inn_army_nor_unit_marauder_berserkers"); -- units
-------------------------------------------------------------------------------------------------
----------------------------------------- ARMY TELEPORT -----------------------------------------
-------------------------------------------------------------------------------------------------



-------------------------------------------------------------------------------------------------
------------------------------------------- CUTSCENE --------------------------------------------
-------------------------------------------------------------------------------------------------



-------------------------------------------------------------------------------------------------
------------------------------------------ ORDERS -------------------------------------------
-------------------------------------------------------------------------------------------------

ga_battle_the_last_hope_inn_character_name_nor:defend_on_message("deployment_started", -5.0, 100.0, 50); -- x/y radius
ga_battle_the_last_hope_inn_army_nor_unit_marauder_spearman:defend_on_message("deployment_started", -5.0, 100.0, 50); -- x/y radius
ga_battle_the_last_hope_inn_army_nor_unit_marauder_warwolves_chariot:defend_on_message("deployment_started", -5.0, 100.0, 50); -- x/y radius
ga_battle_the_last_hope_inn_army_nor_unit_marauder_berserkers:defend_on_message("deployment_started", -5.0, 100.0, 50); -- x/y radius; 

-- proximity to enemy setup --
ga_player:message_on_proximity_to_enemy("proximity_to_enemy", 160); 

ga_battle_the_last_hope_inn_character_name_nor:attack_on_message("proximity_to_enemy");
ga_battle_the_last_hope_inn_army_nor_unit_marauder_spearman:attack_on_message("proximity_to_enemy");
ga_battle_the_last_hope_inn_army_nor_unit_marauder_warwolves_chariot:attack_on_message("proximity_to_enemy");
ga_battle_the_last_hope_inn_army_nor_unit_marauder_berserkers:attack_on_message("proximity_to_enemy"); 

-- under attack setup -- 
ga_battle_the_last_hope_inn_character_name_nor:message_on_under_attack("under_attack");
ga_battle_the_last_hope_inn_army_nor_unit_marauder_spearman:message_on_under_attack("under_attack");
ga_battle_the_last_hope_inn_army_nor_unit_marauder_warwolves_chariot:message_on_under_attack("under_attack");
ga_battle_the_last_hope_inn_army_nor_unit_marauder_berserkers:message_on_under_attack("under_attack"); 

ga_battle_the_last_hope_inn_character_name_nor:attack_on_message("under_attack");
ga_battle_the_last_hope_inn_army_nor_unit_marauder_spearman:attack_on_message("under_attack");
ga_battle_the_last_hope_inn_army_nor_unit_marauder_warwolves_chariot:attack_on_message("under_attack");
ga_battle_the_last_hope_inn_army_nor_unit_marauder_berserkers:attack_on_message("under_attack"); 

ga_battle_the_last_hope_inn_character_name_emp_ally:reinforce_on_message("under_attack", 10000); -- reinforce from the last hop inn
ga_battle_the_last_hope_inn_army_emp_ally_huntsmen:reinforce_on_message("under_attack", 20000); -- reinforce from the last hop inn



-------------------------------------------------------------------------------------------------
------------------------------------------- OBJECTIVES ------------------------------------------
-------------------------------------------------------------------------------------------------

gb:set_objective_on_message("deployment_started", "mission_sjoktraken_the_last_hope_inn_objective_1_tooltip"); -- Liberate the Last Hope Inn
gb:set_objective_on_message("deployment_started", "mission_sjoktraken_the_last_hope_inn_objective_2_tooltip"); -- Pave the way for the Caravan

-------------------------------------------------------------------------------------------------
--------------------------------------------- HINTS/MESSAGES ---------------------------------------------
-------------------------------------------------------------------------------------------------
gb:queue_help_on_message("battle_started", "mission_sjoktraken_the_last_hope_inn_objective_3_message", 8000, 2000, 1000); -- (Grunnar Vestgrud) "Break the Norsemen, to long have they tainted this Land"   
gb:queue_help_on_message("under_attack", "mission_sjoktraken_the_last_hope_inn_objective_4_message", 8000, 2000, 1000); -- (Grunnar Vestgrud) "The men of the Inn is with us!"  
