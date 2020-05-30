PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS

local digForComponent = mod.digForComponent

--- Units that can be recruited via the BoG.
mod.bog_pages = mod.bog_pages or {
	{
		title = "Irondrakes",
		desc = "The bitter underground wars that the Dwarfs fight daily to protect their Holds are evolving, as the Dwarfs' foes come up with diabolical plans to get past Dwarfen defences. Time and again, the Dwarfs' courage and rune-enhanced weapons and armour have turned the tide, yet their foes have learned; when Skaven find the corridor blocked by unmovable Ironbreakers, they call for their own loathsome countermeasures - Warpflame-spewing fire throwers, gas grenades or cobbled-together chopping machines. For their part, Night Goblins turn to mushroom-addled ball and chain-wielding Fanatics, Cave Squigs or Troll mobs.",
		img = "ui/units/minspec_portholes/wh_main_dwf_inf_irondrakes_0.png",
		payload = function() mod.add_unit_to_army("wh_main_dwf_inf_irondrakes_0") end,
		save_id = "pj_quests_irondrake_recruitment",
		limit = 1,
	},
	{
		title = "Warriors",
		desc = "Dwarfs make formidable fighters - they are strong and extremely resilient, broad of shoulder and wide of girth. Although by no means quick, they are physically robust and can maintain a steady plodding pace, marching for days on end despite being loaded down by burdens and heavy mail.",
		img = "ui/units/minspec_portholes/wh_main_dwf_inf_dwarf_warrior_1.png",
		payload = function() mod.add_unit_to_army("wh_main_dwf_inf_dwarf_warrior_0") end,
		cost = 500,
	},
	{
		title = "Miners",
		desc = "When Dwarfs march to war, many mining Clans form regiments to join the battle. As a point of pride, they do not bear axes, but instead wield the same heavy two-handed mining picks and mattocks they use to laboriously carve out tunnels. As it turns out, these well-balanced and sturdily-made tools work equally well whether digging in to bedrock or hacking apart Goblins.",
		img = "ui/units/minspec_portholes/wh_main_dwf_inf_miners_0.png",
		payload = function() mod.add_unit_to_army("wh_main_dwf_inf_miners_0") end,
		cost = 500,
	},
	{
		title = "Quarellers",
		desc = "When the Clans are called to fight, some Dwarfs arm themselves with crossbows and join the battle as Quarrellers. These formations are tasked with raining bolts down upon their foes - a task they perform with orderly zeal. Quarrellers seek to thin down the enemy's ranks, punish units attempting to outflank their own forces and engage in ranged duels with the foe's missile-armed troops. Dwarfs have never taken to bows, partly because they do not suit their short physical stature, but also due to the limitations of such weapons in confined tunnels.",
		img = "ui/units/minspec_portholes/wh_main_dwf_inf_quarrellers_1.png",
		payload = function() mod.add_unit_to_army("wh_main_dwf_inf_quarrellers_0") end,
		cost = 500,
	},
	{
		title = "Rangers",
		desc = "Rangers are the long-ranged eyes and ears of most Dwarf settlements. They patrol far from the safety of the Hold, often spending long periods out in the wilderness, keeping watch on the Dwarfs' many enemies and tracking dangerous beasts. It is they who explore hidden valleys, push through collapsed sections of the Underway and scale the cliffsides in search of new pathways. Rangers will hunt down and dispose of lone monsters or ambush small mobs of Goblins, but when they confront larger creatures or enemy armies on the march, signals are sent to the nearest outposts to alert them of the encroaching danger.",
		img = "ui/units/minspec_portholes/wh_dlc06_dwf_inf_rangers_0.png",
		payload = function() mod.add_unit_to_army("wh_dlc06_dwf_inf_rangers_0") end,
		cost = 500,
	},
}

--- Add a bunch of grudges so we can have pages to turn in the Book of Grudges.
mod.add_grudges = function()
	cm:disable_event_feed_events(true, "all", "", "")
	for i=1, 6 do
		local grudge_mission = mission_manager:new(
		cm:get_local_faction(true),
		"wh_dlc06_grudge_belegar_eight_peaks"
		);

		grudge_mission:add_new_objective("CONSTRUCT_N_BUILDINGS_FROM");
		grudge_mission:add_condition("total 1")
		grudge_mission:add_condition("building_level wh_main_dwf_barracks_3")
		grudge_mission:add_condition("faction wh_main_dwf_dwarfs");
		grudge_mission:add_payload("effect_bundle{bundle_key wh_dlc06_bundle_eight_peaks_recapture;turns 0;}");
		grudge_mission:set_should_cancel_before_issuing(false);
		grudge_mission:trigger();
	end
	cm:disable_event_feed_events(false, "all", "", "")
end

--- Current index of the Book of grudges page on the left, tracked to know when to refresh the BoG UI.
mod.current_bog_page = nil

--- Add a unit to the faction leader.
mod.add_unit_to_army = function(unit_key)
	local char = cm:get_faction(cm:get_local_faction(true)):faction_leader()
	if not char or char:is_null_interface() then return end

	cm:grant_unit_to_character(cm:char_lookup_str(char), unit_key)
end

--- Keep track of currently visible BoG UI components so we can hide them when turning pages.
local current_comps = {}

--- Remove units from the mod.bog_pages list that exceeded their recruitment limit.
mod.remove_invalid_recruitment_entries = function()
	for i=#mod.bog_pages, 1, -1 do
		local page = mod.bog_pages[i]
		if page.limit and page.save_id then
			local save_value = cm:get_saved_value(page.save_id) or 0
			if save_value >= page.limit then
				table.remove(mod.bog_pages, i)
			end
		end
	end
end

--- Simulate clicking the OK button to close the BoG.
mod.close_book_of_grudges = function()
	local book_of_grudges = digForComponent(core:get_ui_root(), "book_of_grudges")
	if not book_of_grudges then return end
	local button_ok = digForComponent(book_of_grudges, "button_ok")
	if not button_ok then return end
	button_ok:SimulateLClick()
end

--- Draw a page of BoG with our own UI.
mod.draw_bog_page = function(page_num)
	local left_list = digForComponent(core:get_ui_root(), "list_left")
	local right_list = digForComponent(core:get_ui_root(), "list_right")

	local page_data = mod.bog_pages[page_num]
	local title = page_data.title
	local desc = page_data.desc

	local list = left_list
	if page_num%2 == 0 then
		list = right_list
	end

	local pages = digForComponent(core:get_ui_root(), "pages")
	local dy_objective = digForComponent(core:get_ui_root(), "dy_objective")
	---@type CA_UIC
	local description_view = digForComponent(core:get_ui_root(), "description_view")
	local tx_objectives_header = digForComponent(description_view, "dy_title")
	local obj = digForComponent(core:get_ui_root(), "objective_copy_"..tostring(page_num))
	local header = digForComponent(core:get_ui_root(), "tx_objectives_header_copy_"..tostring(page_num))

	if not obj then
		obj = UIComponent(dy_objective:CopyComponent("objective_copy_"..tostring(page_num)))
		header = UIComponent(tx_objectives_header:CopyComponent("tx_objectives_header_copy_"..tostring(page_num)))
		pages:Adopt(header:Address())
		pages:Adopt(obj:Address())
	end
	obj:SetVisible(true)
	header:SetVisible(true)
	table.insert(current_comps, obj)
	table.insert(current_comps, header)

	local x, y = list:Position()
	if header then
		header:MoveTo(x+115, y+100)
		header:RegisterTopMost()
		header:SetStateText(title)
	end
	if obj then
		local w = obj:Width()
		obj:SetCanResizeHeight(true)
		obj:Resize(w, 48*3+20)
		obj:MoveTo(x+40, y+450-20)
		obj:RegisterTopMost()
		obj:SetStateText(desc)
	end

	local img = Util.getComponentWithName("rec_l_img_"..tostring(page_num))
	if img then
		img.uic:SetImagePath(page_data.img)
	else
		img = Image.new("rec_l_img_"..tostring(page_num), pages, page_data.img)
	end
	img:Resize(200, 200)
	img:PositionRelativeTo(list, 190, 180)

	local rec_button = Util.getComponentWithName("pj_rec_button_"..tostring(page_num)) or TextButton.new("pj_rec_button_"..tostring(page_num), pages, "TEXT", "Recruit")
	if page_data.limit then
		local save_value = cm:get_saved_value(page_data.save_id) or 0
		local num_available_for_recruitment = page_data.limit - save_value
		rec_button:SetButtonText("Recruit ".."("..tostring(num_available_for_recruitment).." available)")
	else
		rec_button:SetButtonText("Recruit")
	end

	rec_button:PositionRelativeTo(list, 100+25, 625)
	rec_button:Resize(350, 50)

	img:SetVisible(true)
	rec_button:SetVisible(true)
	table.insert(current_comps, img)
	table.insert(current_comps, rec_button)

	local rec_button_listener_id = "pj_rec_button_"..tostring(page_num).."_on_click"
	core:remove_listener(rec_button_listener_id)
	core:add_listener(
		rec_button_listener_id,
		"ComponentLClickUp",
		function(context)
			return rec_button.uic == UIComponent(context.component);
		end,
		function()
			if not page_data.payload then return end
			page_data.payload()
			if page_data.cost then
				cm:treasury_mod(cm:get_local_faction(true), -page_data.cost)
			end

			if page_data.limit then
				local save_value = cm:get_saved_value(page_data.save_id) or 0
				cm:set_saved_value(page_data.save_id, save_value+1)
				cm:callback(
					function()
						mod.remove_invalid_recruitment_entries()
					end,
					1
				)
			end

			mod.close_book_of_grudges()
		end,
		true
	)

	if page_data.cost then
		rec_button.uic:SetTooltipText("Costs "..tostring(page_data.cost).."[[img:icon_money]][[/img]]", true)
		local local_treasury = cm:get_faction(cm:get_local_faction(true)):treasury()
		if local_treasury < page_data.cost then
			rec_button:SetDisabled(true)
		end
	end
end

--- Redraw the opened BoG with our own UI.
mod.redraw_bog = function(page_num)
	local book_of_grudges = digForComponent(core:get_ui_root(), "book_of_grudges")
	if not book_of_grudges then return end

	local bog_priority = book_of_grudges:Priority()
	if bog_priority ~= 200 then
		book_of_grudges:PropagatePriority(200)
		book_of_grudges:LockPriority()
	end

	local grudge_bar = digForComponent(book_of_grudges, "grudge_bar")
	grudge_bar:SetVisible(false)

	local tx_header = digForComponent(book_of_grudges, "tx_header")
	tx_header:SetStateText("Recruitment Ledger")

	local l = digForComponent(book_of_grudges, "list_left")
	local r = digForComponent(book_of_grudges, "list_right")
	l:SetVisible(false)
	r:SetVisible(false)

	for _, comp in ipairs(current_comps) do
		comp:SetVisible(false)
	end

	current_comps = {}

	if mod.bog_pages[page_num] then
		mod.draw_bog_page(page_num)
	end
	if mod.bog_pages[page_num+1] then
		mod.draw_bog_page(page_num+1)
	end
end

local function init()
	mod.add_grudges()
	mod.remove_invalid_recruitment_entries()

	-- start running the book of grudges update loop when we open the Book of Grudges panel
	core:remove_listener("pj_quests_on_book_of_grudges_panel_opened")
	core:add_listener(
		"pj_quests_on_book_of_grudges_panel_opened",
		"PanelOpenedCampaign",
		function(context)
			return context.string == "book_of_grudges"
		end,
		function()
			cm:remove_callback("pj_quests_book_of_grudges_update_id")
			cm:repeat_callback(
				function()
					local book_of_grudges = digForComponent(core:get_ui_root(), "book_of_grudges")
					if not book_of_grudges then return end
					local dy_page = digForComponent(book_of_grudges, "dy_page")
					if not dy_page then return end
					local text = dy_page:GetStateText()
					local current_page = tonumber(string.sub(text, 1, string.find(text, "/")-1))
					if not mod.current_bog_page or mod.current_bog_page ~= current_page then
						mod.current_bog_page = current_page
						mod.redraw_bog(current_page*2-1)
					end
				end,
				0.1,
				"pj_quests_book_of_grudges_update_id"
			)
		end,
		true
	)

	-- stop running the book of grudges update loop
	core:remove_listener("pj_quests_on_book_of_grudges_panel_closed")
	core:add_listener(
		"pj_quests_on_book_of_grudges_panel_closed",
		"PanelClosedCampaign",
		function(context)
			return context.string == "book_of_grudges"
		end,
		function()
			cm:remove_callback("pj_quests_book_of_grudges_update_id")
			mod.current_bog_page = nil
		end,
		true
	)
end

cm:add_first_tick_callback(function()
	init()
end)
