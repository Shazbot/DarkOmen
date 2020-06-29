cm:add_first_tick_callback(function()
	if not cm:is_new_game() then
		return
	end

	cm:fade_scene(0, 0)

	cm:callback(function()
		cm:disable_event_feed_events(true, "all", "", "")
		cm:treasury_mod("wh2_main_dwf_karak_zorn", -10000)
		cm:trigger_dilemma("wh2_main_dwf_karak_zorn", "intro")
		local local_faction = cm:get_faction(cm:get_local_faction(true))
		cm:kill_character(local_faction:faction_leader():cqi(),true, false)
		cm:create_force_with_general(
			local_faction:name(),
			"dwf_norse_hammerers,dwf_norse_longbeards,dwf_norse_rangers,dwf_norse_warrior,dwf_norse_quarrellers",
			"wh_main_blood_river_valley_varenka_hills",
			710,
			624,
			"general",
			"dwf_norse_lord",
			"names_name_7884153401",
			"",
			"names_name_7884153402",
			"",
			true,
			function(cqi)
			end
		)
		cm:disable_event_feed_events(false, "all", "", "")

		cm:callback(function()
			local char = cm:get_faction(cm:get_local_faction(true)):faction_leader()
			cm:teleport_to(cm:char_lookup_str(char), 710, 624, false) -- start position
			cm:callback(function()
				cm:move_to(cm:char_lookup_str(char), 709, 624, false)
			end, 0.5)

			cm:scroll_camera_from_current(true, 0.01, {473.84, 480.21, 3, d_to_r(0), 3})
			cm:fade_scene(1, 5)
		end, 0.1)
	end, 5)

end)

cm:add_first_tick_callback(function()
	local ui_root = core:get_ui_root()

	for _, button_id in ipairs({"button_diplomacy", "button_missions", "button_technology", "button_mortuary_cult"}) do
		local button = find_uicomponent(ui_root, "layout", "faction_buttons_docker", "button_group_management", button_id)
		if button then
			button:SetVisible(false)
		end
	end

	local button_grudges = find_uicomponent(ui_root, "layout", "faction_buttons_docker", "button_group_management", "button_grudges")
	if button_grudges then
		button_grudges:SetTooltipText("Recruitment Ledger", true)
	end

	local button_end_turn = find_uicomponent(ui_root, "layout", "faction_buttons_docker", "end_turn_docker", "button_end_turn")
	if button_end_turn then
		button_end_turn:SetDisabled(true)
	end

	cm:force_diplomacy("faction:" .. cm:get_local_faction(true), "faction:wh_main_dwf_kraka_drak", "war", false, false, true);
end)
