PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS

local digForComponent = mod.digForComponent

cm:add_first_tick_callback(function()
	core:remove_listener('pj_quests_on_intro_button_clicked')
	core:add_listener(
		'pj_quests_on_intro_button_clicked',
		'ComponentLClickUp',
		function(context)
			return context.string == "pj_quests_intro_button"
		end,
		function()
			mod.intro_button:SetState("hover")
			mod.create_event_frame()
		end,
		true
	)

	local tech_button = digForComponent(core:get_ui_root(), "button_technology")
	if tech_button and not mod.button then
		mod.intro_button = UIComponent(tech_button:CopyComponent("pj_quests_intro_button"))
	end

	mod.intro_button:SetTooltipText("Norse Dwarfs Intro||Show the intro panel.", true)
end)

mod.create_event_frame = function()
	CampaignUI.ClearSelection()

	local existingFrame = Util.getComponentWithName("pj_quests_event_frame")
	if existingFrame then
			return
	end

	local myFrame = Frame.new("pj_quests_event_frame")

	local frame_title_uic = find_uicomponent(myFrame.uic, "panel_title", "tx_objectives")
	frame_title_uic:SetStateText("Reuniting Lost Kin")

	myFrame:Resize(920-120, 800+100+150+75)
	Util.centreComponentOnScreen(myFrame)
	-- myFrame:Move(0, 0)
	myFrame.uic:RegisterTopMost()

	local traitImage = Image.new("pj_quests_event_bg_image", myFrame, "ui/eventpics/dwf/land_victory.png");
	traitImage:Resize(380*1.4, 214*1.4)
	traitImage:Move(5+125, 5+150)

	local quest_description_title = Text.new("pj_quests_event_description_title", myFrame, "NORMAL", "")--mission_sjoktraken_shipwreck.locs.title)
	local quest_description = Text.new("pj_quests_event_description", myFrame, "NORMAL", "")--mission_sjoktraken_shipwreck.locs.mission_desc)
	quest_description:Resize(545+150, 300)
	quest_description_title:Resize(545+350, 50)
	quest_description_title:PositionRelativeTo(myFrame, 275+70+130-252/2-120/2, 140+3*50-80+200)
	quest_description:PositionRelativeTo(myFrame, 275+70-75-252/2-120/2-30, 140+3*50-40+200)

	local title = "Reuniting Lost Kin"
	local text_width = quest_description_title.uic:TextDimensionsForText(title)
	quest_description_title:PositionRelativeTo(myFrame, 275+55-252/2+238-120/2-text_width/2, 140+3*50-80+200)
	quest_description_title:SetText(title)
	quest_description:SetText("Reuniting Lost Kin, tells the story of how the Northern Dwarfs and their Southern relatives reunite.\n\n"
	.."Isolated in the cold north, the Norse Dwarfs have not been in contact with their kislevian neighbors for 137 years and the last envoy from a sourthen hold departed Sjoktraken 367 years ago. In their imposed solitude, darkness and despair is flourishing.\n\n"
	.."On a particular bright spring day in the year 2047 of the imperial calendar the Northern Dwarfs faith is redefined. One of the numerous requests by Thrane Torken Ironvein is finally accepted by the High King. Ironvein is allowed to leave the realm with a smaller retinue bound for the kislevian borders and beyond to the Grand city of Kislev. It is Ironvein's hope that the city of the Gospars still stands and that the dwarven embassy to the Holds of Karak Kadrin still resides within its walls.\n\n"
	.."Short on dwarfs for the trip, Ironvein decides to enroll sell swords in his endeavors - promising riches onces at the gates of the Grand city of Kislev."
	)
	local parchment = digForComponent(myFrame.uic, "parchment")
	if parchment then
		parchment:SetDockOffset(0, 162)
	end
	local bg_img = digForComponent(myFrame.uic, "pj_quests_event_bg_image")
	if bg_img then
		local img_x, img_y = bg_img:Position()
		bg_img:MoveTo(img_x, img_y-70-15)
	end
	myFrame:AddCloseButton(function()
	end)
end
