PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS

local digForComponent = mod.digForComponent

--- Adjust the camera settings.
--- We want no zoom on army movement and slow army movement speed.
mod.adjust_camera_settings = function()
	local layout = digForComponent(core:get_ui_root(), "layout")
	if layout then
		layout:SetVisible(true)
		layout:PropagateOpacity(255)
	end
	local ui_parent = digForComponent(core:get_ui_root(), "3d_ui_parent")
	if ui_parent then
		ui_parent:SetVisible(true)
	end
	local menu_bar = digForComponent(core:get_ui_root(), "menu_bar")
	if menu_bar then
		menu_bar:SetVisible(true)
	end
	if PJ_SS then PJ_SS.dow_main_ui_button:SetVisible(false) end

	local settings_button = find_uicomponent(core:get_ui_root(), "menu_bar", "buttongroup", "button_settings")
	if settings_button and settings_button:CurrentState() ~= "selected" then
		settings_button:SimulateLClick()
	end
	cm:callback(function()
		local apply_player = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "buttons_list", "apply_player")
		if apply_player and apply_player:CurrentState() ~= "selected" then
			apply_player:SimulateLClick()
		end

		cm:callback(function()
			local option0 = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "dropdowns_list", "armies", "dropdown_armies_camera", "popup_menu", "popup_list", "option0")
			if option0 then
				option0:SimulateLClick()
			end
			local option0 = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "dropdowns_list", "armies", "dropdown_armies_speed", "popup_menu", "popup_list", "option0")
			if option0 then
				option0:SimulateLClick()
			end
			cm:callback(function()
				local button_close = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "button_holder", "button_close")
				if button_close then
					button_close:SimulateLClick()
				end
			end, 0.1)
		end, 0.1)
	end, 0.1)
end

cm:add_first_tick_callback(function()
	core:remove_listener("pj_wait_for_teleport_button_cb")
	core:add_listener(
			"pj_wait_for_teleport_button_cb",
			"RealTimeTrigger",
			function(context)
					return context.string == "pj_wait_for_teleport_button"
			end,
			function()
				local teleport_button = digForComponent(core:get_ui_root(), "button_teleport")
				if teleport_button then
					real_timer.unregister("pj_wait_for_teleport_button")
					real_timer.unregister("pj_wait_for_start_battle_button")
					real_timer.register_repeating("pj_wait_for_start_battle_button", 0)
					teleport_button:SimulateLClick()
				end
			end,
			true
	)

	core:remove_listener("pj_wait_for_start_battle_button_cb")
	core:add_listener(
			"pj_wait_for_start_battle_button_cb",
			"RealTimeTrigger",
			function(context)
					return context.string == "pj_wait_for_start_battle_button"
			end,
			function()
				local button_tick = find_uicomponent(
					core:get_ui_root(),
					"dialogue_box","ok_group", "button_tick"
				)
				if button_tick then
					real_timer.unregister("pj_wait_for_start_battle_button")
					button_tick:SimulateLClick()
				end
			end,
			true
	)
end)

--- Start a quest and immediately start the battle.
mod.force_start_quest_battle = function(quest_key)
	real_timer.unregister("pj_wait_for_teleport_button")
	real_timer.register_repeating("pj_wait_for_teleport_button", 0)
	cm:trigger_mission(cm:get_local_faction(true), quest_key, true)
end

--- Select the first lord/army of the local faction.
--- We simulate the user clicking in the list of armies UI tab.
mod.select_first_lord = function()
	-- find and open the lords dropdown
	local tab_units = find_uicomponent(
		core:get_ui_root(),
		"layout","bar_small_top", "TabGroup", "tab_units"
	)

	if tab_units:CurrentState() ~= "selected" then
		tab_units:SimulateLClick()
	end

	local units_dropdown = digForComponent(core:get_ui_root(), "units_dropdown")
	---@type CA_UIC
	local list_clip = digForComponent(units_dropdown, "list_clip")
	for i=0, list_clip:ChildCount()-1 do
		local comp = UIComponent(list_clip:Find(i))
		if comp:Id() == "list_box" then
			local char_row = UIComponent(comp:Find(0))
			CampaignUI.ClearSelection()
			char_row:SimulateLClick()
		end
	end
end
