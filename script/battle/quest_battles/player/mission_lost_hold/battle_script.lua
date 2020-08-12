-------------------------------------------------------------------------------------------------
------------------------------------------- KEY INFO --------------------------------------------
-------------------------------------------------------------------------------------------------
-- ReunitingLostKins
-- mission_lost_hold
-- attacker
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
ga_player = gb:get_army(gb:get_player_alliance_num(), 1, ""); -- attacker
------------------------------------------ALLY---------------------------------------------------
ga_battle_lost_hold_character_name_dwf_ally = gb:get_army(gb:get_player_alliance_num(),"battle_lost_hold_character_name_dwf_ally"); -- #0 Char + units
ga_battle_lost_hold_character_name_dwf_ally_1 = gb:get_army(gb:get_player_alliance_num(),"battle_lost_hold_character_name_dwf_ally_1"); -- #1 Char + units
--ga_battle_lost_hold_character_name_dwf_ally_2 = gb:get_army(gb:get_player_alliance_num(),"battle_lost_hold_character_name_dwf_ally_2"); -- #2 Char + units

 ------------------------------------------ENEMY---------------------------------------------------
ga_battle_lost_hold_character_name_nor = gb:get_army(gb:get_non_player_alliance_num(),"battle_lost_hold_character_name_nor"); -- #0 Char + units
ga_battle_lost_hold_character_name_nor_1 = gb:get_army(gb:get_non_player_alliance_num(),"battle_lost_hold_character_name_nor_1"); -- #1 Char + units
--ga_battle_lost_hold_character_name_nor_2 = gb:get_army(gb:get_non_player_alliance_num(),"battle_lost_hold_character_name_nor_2"); -- #2 Char + units

-------------------------------------------------------------------------------------------------
------------------------------------------ OBJECTIVES -------------------------------------------
-------------------------------------------------------------------------------------------------

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
---------------------------------------ALLY DEFENDS-----------------------------------------------
--------------------------------------------------------------------------------------------------
--ga_battle_lost_hold_character_name_dwf_ally:defend_on_message("battle_started", 251, -132, 50);
-------------------------------------------------------------------------------------------------
-------------------------------------- REINFORCEMENT --------------------------------------------
-------------------------------------------------------------------------------------------------
ga_battle_lost_hold_character_name_nor_1:reinforce_on_message("Wait_1min", 10000);
--ga_battle_lost_hold_character_name_nor_2:deploy_at_random_intervals_on_message("Wait_3min",1,2,60000,60000); 

ga_battle_lost_hold_character_name_dwf_ally_1:reinforce_on_message("Wait_1min", 10000);
--ga_battle_lost_hold_character_name_dwf_ally_2:deploy_at_random_intervals_on_message("Wait_3min",1,2,60000,60000); 

-------------------------------------------------------------------------------------------------
--------------------------------------------- HINTS/MESSAGES ---------------------------------------------
-------------------------------------------------------------------------------------------------


-------------------------------------------------TESTING------------------------------------

