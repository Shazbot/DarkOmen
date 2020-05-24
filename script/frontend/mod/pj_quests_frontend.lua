local digForComponent = function(startingComponent, componentName, max_depth)
	local function digForComponent_iter(startingComponent, componentName, max_depth, current_depth)
		local childCount = startingComponent:ChildCount()
		for i=0, childCount-1  do
				local child = UIComponent(startingComponent:Find(i))
				if child:Id() == componentName then
						return child
				else
					if not max_depth or current_depth+1 <= max_depth then
						local dugComponent = digForComponent_iter(child, componentName, max_depth, current_depth+1)
						if dugComponent then
								return dugComponent
						end
					end
				end
		end
		return nil
	end

	return digForComponent_iter(startingComponent, componentName, max_depth, 1)
end

local function create_frontend_listeners()
	core:add_listener(
		"pj_quests_on_sp_grand_campaign_transition",
		"FrontendScreenTransition",
		function(context) return context.string == "sp_grand_campaign" end,
		function()
			local faction_list = find_uicomponent(core:get_ui_root(), "sp_grand_campaign", "dockers", "top_docker", "lord_select_list", "list", "list_clip", "list_box");
			if not faction_list then
				return
			end

			for i = 0, faction_list:ChildCount() - 1 do
				local child = UIComponent(faction_list:Find(i))
				if child:Id() ~= "Thrund Holdfast" then
					child:SetVisible(false)
				else
					child:SimulateLClick()
				end
			end
		end,
		true
	)

	core:add_listener(
		"pj_quests_on_campaign_select_transition",
		"FrontendScreenTransition",
		function(context) return context.string == "campaign_select" end,
		function()
			local wh2_main_great_vortex = digForComponent(core:get_ui_root(), "wh2_main_great_vortex")
			if wh2_main_great_vortex then
				wh2_main_great_vortex:SetVisible(false)
			end

			local main_warhammer = digForComponent(core:get_ui_root(), "main_warhammer")
			if not main_warhammer then return end

			local button_campaign_entry = digForComponent(main_warhammer, "button_campaign_entry")
			if not button_campaign_entry then return end

			button_campaign_entry:SimulateLClick()
		end,
		true
	)
end

core:add_ui_created_callback(
	function()
		create_frontend_listeners()
	end
)
