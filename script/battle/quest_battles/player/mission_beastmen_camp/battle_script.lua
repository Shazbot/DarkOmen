-------------------------------------------------------------------------------------------------
------------------------------------------- KEY INFO --------------------------------------------
-------------------------------------------------------------------------------------------------
-- ReunitingLostKins
-- mission_kraka_drak_beastmen_camp
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
	true,                                      		-- screen starts black
	false,                                     		-- prevent deployment for player
	false,                                      	-- prevent deployment for ai
	function() gb:start_generated_cutscene(gc) end, -- intro cutscene function
	false                                      		-- debug mode
);

gb:set_cutscene_during_deployment(true);

-------------------------------------------------------------------------------------------------
---------------------------------------- INTRO VO & SUBS ----------------------------------------
-------------------------------------------------------------------------------------------------



-------------------------------------------------------------------------------------------------
------------------------------------------ ARMY SETUP -------------------------------------------
-------------------------------------------------------------------------------------------------
ga_player = gb:get_army(gb:get_player_alliance_num(), 1, ""); -- player attacker 

ga_battle_beastmen_camp_character_name_dwf_ally = gb:get_army(gb:get_player_alliance_num(),"battle_beastmen_camp_character_name_dwf_ally"); -- char/army
ga_battle_beastmen_camp_army_dwf_ally_unit_slayers = gb:get_army(gb:get_player_alliance_num(),"battle_beastmen_camp_army_dwf_ally_unit_slayers"); -- units

ga_battle_beastmen_camp_character_name_bst = gb:get_army(gb:get_non_player_alliance_num(),"battle_beastmen_camp_character_name_bst"); -- char/army
ga_battle_beastmen_camp_army_bst_unit_gor_herd = gb:get_army(gb:get_non_player_alliance_num(),"battle_beastmen_camp_army_bst_unit_gor_herd"); -- units
ga_battle_beastmen_camp_army_bst_unit_ungor_spearmen = gb:get_army(gb:get_non_player_alliance_num(),"battle_beastmen_camp_army_bst_unit_ungor_spearmen"); -- units
ga_battle_beastmen_camp_army_bst_unit_centigors = gb:get_army(gb:get_non_player_alliance_num(),"battle_beastmen_camp_army_bst_unit_centigors"); -- units
ga_battle_beastmen_camp_army_bst_unit_ungor_raiders = gb:get_army(gb:get_non_player_alliance_num(),"battle_beastmen_camp_army_bst_unit_ungor_raiders"); -- units
ga_battle_beastmen_camp_army_bst_unit_minotaurs = gb:get_army(gb:get_non_player_alliance_num(),"battle_beastmen_camp_army_bst_unit_minotaurs"); -- units
-------------------------------------------------------------------------------------------------
----------------------------------------- ARMY TELEPORT -----------------------------------------
-------------------------------------------------------------------------------------------------



-------------------------------------------------------------------------------------------------
------------------------------------------- CUTSCENE --------------------------------------------
-------------------------------------------------------------------------------------------------



-------------------------------------------------------------------------------------------------
------------------------------------------ ORDERS -------------------------------------------
-------------------------------------------------------------------------------------------------

ga_battle_beastmen_camp_character_name_bst:defend_on_message("deployment_started", -25.0, -190.0, 50); -- x/y radius
ga_battle_beastmen_camp_army_bst_unit_gor_herd:defend_on_message("deployment_started", -25.0, -190.0, 50); -- x/y radius
ga_battle_beastmen_camp_army_bst_unit_ungor_spearmen:defend_on_message("deployment_started", -25.0, -190.0, 50); -- x/y radius
ga_battle_beastmen_camp_army_bst_unit_centigors:defend_on_message("deployment_started", -25.0, -190.0); -- x/y radius
ga_battle_beastmen_camp_army_bst_unit_ungor_raiders:defend_on_message("deployment_started", -25.0, -190.0, 50); -- x/y radius
ga_battle_beastmen_camp_army_bst_unit_minotaurs:defend_on_message("deployment_started", -25.0, -190.0, 50); -- x/y radius

-- proximity to enemy setup --
ga_player:message_on_proximity_to_enemy("proximity_to_enemy", 160); 
ga_battle_beastmen_camp_character_name_dwf_ally:message_on_proximity_to_enemy("proximity_to_enemy", 160); 
ga_battle_beastmen_camp_army_dwf_ally_unit_slayers:message_on_proximity_to_enemy("proximity_to_enemy", 160); 

ga_battle_beastmen_camp_character_name_bst:attack_on_message("proximity_to_enemy");
ga_battle_beastmen_camp_army_bst_unit_gor_herd:attack_on_message("proximity_to_enemy");
ga_battle_beastmen_camp_army_bst_unit_ungor_spearmen:attack_on_message("proximity_to_enemy");
ga_battle_beastmen_camp_army_bst_unit_centigors:attack_on_message("proximity_to_enemy");
ga_battle_beastmen_camp_army_bst_unit_ungor_raiders:attack_on_message("proximity_to_enemy");
ga_battle_beastmen_camp_army_bst_unit_minotaurs:attack_on_message("proximity_to_enemy");

-- under attack setup -- 
ga_battle_beastmen_camp_character_name_bst:message_on_under_attack("under_attack");
ga_battle_beastmen_camp_army_bst_unit_gor_herd:message_on_under_attack("under_attack");
ga_battle_beastmen_camp_army_bst_unit_ungor_spearmen:message_on_under_attack("under_attack");
ga_battle_beastmen_camp_army_bst_unit_centigors:message_on_under_attack("under_attack");
ga_battle_beastmen_camp_army_bst_unit_ungor_raiders:message_on_under_attack("under_attack");
ga_battle_beastmen_camp_army_bst_unit_minotaurs:message_on_under_attack("under_attack");

ga_battle_beastmen_camp_character_name_bst:attack_on_message("under_attack");
ga_battle_beastmen_camp_army_bst_unit_gor_herd:attack_on_message("under_attack");
ga_battle_beastmen_camp_army_bst_unit_ungor_spearmen:attack_on_message("under_attack");
ga_battle_beastmen_camp_army_bst_unit_centigors:attack_on_message("under_attack");
ga_battle_beastmen_camp_army_bst_unit_ungor_raiders:attack_on_message("under_attack");
ga_battle_beastmen_camp_army_bst_unit_minotaurs:attack_on_message("under_attack");

-- Rune lord objective fail setup --
ga_battle_beastmen_camp_character_name_dwf_ally:message_on_shattered_proportion("battle_beastmen_camp_character_name_dwf_ally_dead", 0.95); -- Dead char /or fleeing
gb:fail_objective_on_message("battle_beastmen_camp_character_name_dwf_ally_dead", "mission_kraka_drak_beastmen_camp_objective_2_tooltip", 5); -- fail setup
ga_battle_beastmen_camp_character_name_bst:force_victory_on_message("battle_beastmen_camp_character_name_dwf_ally_dead", 10000); -- Force loss -> Ensure the Rune Lord's survival
-------------------------------------------------------------------------------------------------
------------------------------------------- OBJECTIVES ------------------------------------------
-------------------------------------------------------------------------------------------------

gb:set_objective_on_message("deployment_started", "mission_kraka_drak_beastmen_camp_objective_1_tooltip"); -- Get the Rune Lord to the Rift  
gb:set_objective_on_message("deployment_started", "mission_kraka_drak_beastmen_camp_objective_2_tooltip"); -- Ensure the Rune Lord's survival

-------------------------------------------------------------------------------------------------
--------------------------------------------- HINTS/MESSAGES ---------------------------------------------
-------------------------------------------------------------------------------------------------

gb:queue_help_on_message("battle_started", "mission_kraka_drak_beastmen_camp_objective_3_message", 8000, 2000, 1000); -- (Grunnar Vestgrud) "Pave way, Break the Beasts"
