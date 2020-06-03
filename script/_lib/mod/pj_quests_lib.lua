PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS

--- Things in the script/lib folder get run before those in the mod folder.

mod.digForComponent = function(startingComponent, componentName, max_depth)
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

mod.resize_event = function()
	local digForComponent = mod.digForComponent

	local ui_root = core:get_ui_root()
	local es = digForComponent(ui_root, "event_standard")
	local ep = digForComponent(es, "dy_event_picture")
	local pf = digForComponent(es, "dy_movie_frame")
	local list = digForComponent(es, "list")
	local events = digForComponent(ui_root, "events")
	local button_set = digForComponent(events, "button_set")

	local scale = 4

	ep:SetCanResizeWidth(true)
	ep:SetCanResizeHeight(true)
	ep:Resize(380*scale, 214*scale)

	pf:SetCanResizeWidth(true)
	pf:SetCanResizeHeight(true)
	pf:Resize(380*scale, 214*scale)

	local w,h = pf:Width(), pf:Height()

	local screen_x, screen_y = core:get_screen_resolution();
	es:MoveTo(screen_x/2-w/2,screen_y/2-h/2)

	local button_set_w = button_set:Width()

	button_set:MoveTo(screen_x/2-button_set_w/2,screen_y/2+h/2)

	list:SetVisible(false)
end
