-------------------------------------------------------------------------------------------------
------------------------------------------- KEY INFO --------------------------------------------
-------------------------------------------------------------------------------------------------
-- ReunitingLostKins
-- mission_kislev
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
ga_player = gb:get_army(gb:get_player_alliance_num(), 1, "");

ga_battle_kislev_army_player_unit_dwarf_warriors = gb:get_army(gb:get_player_alliance_num(),"battle_kislev_army_player_unit_dwarf_warriors"); -- units

ga_battle_kislev_character_name_skv0 = gb:get_army(gb:get_non_player_alliance_num(),"battle_kislev_character_name_skv0"); -- char
ga_battle_kislev_character_name_skv1 = gb:get_army(gb:get_non_player_alliance_num(),"battle_kislev_character_name_skv1"); -- char
ga_battle_kislev_character_name_skv2 = gb:get_army(gb:get_non_player_alliance_num(),"battle_kislev_character_name_skv2"); -- char
ga_battle_kislev_character_name_skv3 = gb:get_army(gb:get_non_player_alliance_num(),"battle_kislev_character_name_skv3"); -- char
ga_battle_kislev_army_skv0_unit_death_runners = gb:get_army(gb:get_non_player_alliance_num(),"battle_kislev_army_skv0_unit_death_runners"); -- units
ga_battle_kislev_army_skv1_unit_death_runners = gb:get_army(gb:get_non_player_alliance_num(),"battle_kislev_army_skv1_unit_death_runners"); -- units
ga_battle_kislev_army_skv2_unit_death_runners = gb:get_army(gb:get_non_player_alliance_num(),"battle_kislev_army_skv2_unit_death_runners"); -- units
ga_battle_kislev_army_skv3_unit_death_runners = gb:get_army(gb:get_non_player_alliance_num(),"battle_kislev_army_skv3_unit_death_runners"); -- units


--player --
--setup script units --
--player_alliance = alliances:item(1);
--player_army = player_alliance:armies():item(1);
--player_unit_1 = scriptunit:new(player_army, 1)
--player_unit_2 = scriptunit:new(player_army, 2)
--player_unit_3 = scriptunit:new(player_army, 3)

-- grouped script unit"s" --
sunits_player_army = script_units:new(ga_player);

--Skaven enemy--
--setup script units --
--skaven_alliance = alliances:item(2);
--skaven_army = skaven_alliance:armies():item(1); -- item(2) for the second army
--sunit_battle_kislev_character_name_skv0 = script_unit:new(skaven_army, "battle_kislev_character_name_skv0");
--sunit_battle_kislev_army_skv0_unit_death_runners = script_unit:new(skaven_army, "battle_kislev_army_skv0_unit_death_runners");

-- grouped script unit"s" --
sunits_skaven_army1 = script_units:new(ga_battle_kislev_character_name_skv0, ga_battle_kislev_army_skv0_unit_death_runners);

-- assemble the enemy into an ai planner
--ai planner for patrol--
skaven_patrol = script_ai_planner:new("patrol_phase", sunits_skaven_army1);
skaven_patrol:patrol({v(380, 100),v(400, -100),v(400, -260),},sunits_player_army)
-- Need some sort of start mech --

-------------------------------------------------------------------------------------------------
----------------------------------------- ARMY TELEPORT -----------------------------------------
-------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------
------------------------------------------- CUTSCENE --------------------------------------------
-------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------
------------------------------------------ ORDERS -------------------------------------------
-------------------------------------------------------------------------------------------------
ga_battle_kislev_character_name_skv0:defend_on_message("deployment_started", 380, 100, 50); -- x/y radius 
ga_battle_kislev_character_name_skv1:defend_on_message("deployment_started", 380, 100, 50); -- x/y radius
ga_battle_kislev_character_name_skv2:defend_on_message("deployment_started", 380, 100, 50); -- x/y radius
ga_battle_kislev_character_name_skv3:defend_on_message("deployment_started", 380, 100, 50); -- x/y radius
ga_battle_kislev_army_skv0_unit_death_runners:defend_on_message("deployment_started", 380, 100, 50); -- x/y radius
ga_battle_kislev_army_skv1_unit_death_runners:defend_on_message("deployment_started", 380, 100, 50); -- x/y radius
ga_battle_kislev_army_skv2_unit_death_runners:defend_on_message("deployment_started", 380, 100, 50); -- x/y radius
ga_battle_kislev_army_skv3_unit_death_runners:defend_on_message("deployment_started", 380, 100, 50); -- x/y radius

-------------------------------------------------------------------------------------------------
------------------------------------------- OBJECTIVES ------------------------------------------
-------------------------------------------------------------------------------------------------



-------------------------------------------------------------------------------------------------
--------------------------------------------- HINTS/MESSAGES ---------------------------------------------
-------------------------------------------------------------------------------------------------
-- utility tool coordinates --
gb:add_ping_icon_on_message("zoid", v(700, 1, -200), 1, 2000, 700000);
gb:add_ping_icon_on_message("zoid", v(600, 1, -200), 2, 2000, 700000);
gb:add_ping_icon_on_message("zoid", v(500, 1,-200), 1, 2000, 700000);
gb:add_ping_icon_on_message("zoid", v(400, 1, -200), 1, 2000, 700000);
gb:add_ping_icon_on_message("zoid", v(800, 1, -200), 1, 2000, 700000);
gb:add_ping_icon_on_message("zoid", v(900, 1, -200), 1, 2000, 700000);
gb:add_ping_icon_on_message("zoid", v(1000, 1, -200), 1, 2000, 700000);

gb:add_ping_icon_on_message("zoid", v(700, 1, -200), 3, 2000, 700000);
gb:add_ping_icon_on_message("zoid", v(700, 1, -100), 4, 6000, 700000);
gb:add_ping_icon_on_message("zoid", v(700, 1, 0), 3, 6000, 700000);
gb:add_ping_icon_on_message("zoid", v(700, 1, 100), 3, 6000, 700000);
gb:add_ping_icon_on_message("zoid", v(700, 1, -300), 3, 6000, 700000);
gb:add_ping_icon_on_message("zoid", v(700, 1, -400), 3, 6000, 700000);
gb:add_ping_icon_on_message("zoid", v(700, 1, -500), 3, 6000, 700000);



