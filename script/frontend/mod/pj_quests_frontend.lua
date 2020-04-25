local function hide_someone()
	core:add_listener(
		"hurdur_CampaignTransitionListener",
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
end

core:add_ui_created_callback(
	function()
		hide_someone()
	end
)
