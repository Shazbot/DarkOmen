cm:add_first_tick_callback(function()

	cm:fade_scene(0, 0)
	cm:callback(function()
		cm:disable_event_feed_events(true, "all", "", "")

		local local_faction = cm:get_faction(cm:get_local_faction(true))
		cm:kill_character(local_faction:faction_leader():cqi(),true, false)
		cm:create_force_with_general(
			local_faction:name(),
			"dwf_norse_hammerers,wh_main_dwf_inf_miners_1,wh_main_dwf_inf_miners_1,wh_main_dwf_inf_miners_1,wh_main_dwf_inf_quarrellers_0,wh_main_dwf_inf_quarrellers_0,wh_main_dwf_inf_dwarf_warrior_0,wh_main_dwf_inf_dwarf_warrior_0,wh_dlc06_dwf_inf_rangers_0",
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
