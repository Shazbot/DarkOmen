---@return CA_UIC
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

local function binding_iter(binding)
	local pos = 0
	local num_items = binding:num_items()
	return function()
			if pos < num_items then
					local item = binding:item_at(pos)
					pos = pos + 1
					return item
			end
			return
	end
end

local move_rel = function(comp, comp_pivot, x_offset, y_offset)
	local x, y = comp_pivot:Position()
	comp:MoveTo(x+x_offset, y+y_offset)
end

PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS

mod.open_contract_complete_panel = function(gold_gained, payload_on_closed)
	gold_gained = gold_gained or 10000

	local ui_root = core:get_ui_root()
	local cc_panel = digForComponent(core:get_ui_root(), "pj_contract_completed_panel", 1)
	if not cc_panel then
		cc_panel = UIComponent(ui_root:CreateComponent("pj_contract_completed_panel", "ui/campaign ui/finance_screen"))
	end
	cc_panel:SetVisible(true)

	local sw, sh = core:get_screen_resolution()

	local taxes = digForComponent(cc_panel, "taxes")
	taxes:SetCanResizeHeight()
	cc_panel:Resize(850, 1000)

	local parchment = digForComponent(cc_panel, "parchment")
	parchment:SetCanResizeWidth(true)
	parchment:Resize(780+50, 900)

	local tab_taxes = digForComponent(cc_panel, "tab_taxes")
	tab_taxes:SimulateLClick()
	local taxes = digForComponent(tab_taxes, "taxes")
	if taxes then
		cc_panel:Adopt(taxes:Address())
		tab_taxes:SetVisible(false)
	end

	local taxes = digForComponent(cc_panel, "taxes")
	taxes:SetVisible(true)
	taxes:Resize(640, 321+300)
	move_rel(taxes, cc_panel, 114, 80)

	local dy_sum_debit = digForComponent(cc_panel, "dy_sum_debit")
	local tx_total_expenditure = digForComponent(dy_sum_debit, "tx_total_expenditure") -- "Total Expenditure" at the bottom
	local tx_expenditure = digForComponent(cc_panel, "tx_expenditure") -- "Expenditure" title at the top
	local tx_income = digForComponent(cc_panel, "tx_income")
	tx_expenditure:SetVisible(true)
	tx_total_expenditure:SetVisible(true)

	local hbar = find_uicomponent(tx_income, "hbar", "hbar")
	hbar:SetVisible(false)
	local hbar = find_uicomponent(tx_expenditure, "hbar", "hbar")
	hbar:SetVisible(false)

	for i=1, 4 do
		local hbar_prefab = find_uicomponent(cc_panel, "TabGroup", "tab_summary", "summary", "starting treasury", "hbar")
		local new_hbar = find_uicomponent(cc_panel, "pj_hbar_"..i)
		if not new_hbar then
			new_hbar = UIComponent(hbar_prefab:CopyComponent("pj_hbar_"..i))
			cc_panel:Adopt(new_hbar:Address())
		end
		new_hbar:Resize(350, 5)
		move_rel(new_hbar, tx_income, 15, 41)
	end

	local new_hbar = find_uicomponent(cc_panel, "pj_hbar_2")
	move_rel(new_hbar, tx_income, 15, 226+41)

	local faction = cm:get_faction(cm:get_local_faction(true))
	local char = faction:faction_leader()

	local total_price = 0
	local expenditure_i=0
	for unit in binding_iter(char:military_force():unit_list()) do
		---@type CA_UNIT
		local unit = unit
		local unit_key = unit:unit_key()
		local unit_class = unit:unit_class()
		if unit_class ~= "com" then
			local unit_price = unit:get_unit_custom_battle_cost()
			total_price = total_price + unit_price
			local localized_unit_name = effect.get_localised_string("land_units_onscreen_name_"..unit_key)

			local mercs2 = digForComponent(core:get_ui_root(), "mercs"..expenditure_i)
			if not mercs2 then
				mercs2 = UIComponent(dy_sum_debit:CopyComponent("mercs"..expenditure_i))
			end

			local tx_total_expenditure = digForComponent(mercs2, "tx_total_expenditure")
			mercs2:SetStateText("-"..unit_price)
			tx_total_expenditure:SetStateText(localized_unit_name)
			move_rel(mercs2, tx_expenditure, 300, expenditure_i*35+35)
			expenditure_i = expenditure_i+1
		end
	end

	local new_hbar = find_uicomponent(cc_panel, "pj_hbar_3")
	move_rel(new_hbar, tx_expenditure, 15, 41)
	local new_hbar = find_uicomponent(cc_panel, "pj_hbar_4")
	move_rel(new_hbar, tx_expenditure, 15, expenditure_i*35+35+15+5)

	dy_sum_debit:SetStateText("-"..total_price)
	move_rel(dy_sum_debit, tx_expenditure, 300, expenditure_i*35+35+15)
	move_rel(tx_total_expenditure, tx_expenditure, 25, expenditure_i*35+35+15)

	dy_sum_debit:SetVisible(true)

	local tx_total_income = digForComponent(cc_panel, "tx_total_income")

	local income = {
		["Quest"] = gold_gained,
	}

	local total_income = 0
	local income_i = 0
	for income_name, income_value in pairs(income) do
		total_income = total_income + income_value
		local mercs2 = digForComponent(core:get_ui_root(), "mercs_income_"..income_i)
		if not mercs2 then
			mercs2 = UIComponent(tx_total_income:CopyComponent("mercs_income_"..income_i))
		end

		local dy_sum_credit = digForComponent(mercs2, "dy_sum_credit")
		mercs2:SetStateText(income_name)
		dy_sum_credit:SetStateText(income_value)
		move_rel(mercs2, tx_income, 50, income_i*35+35)
		income_i = income_i+1
	end

	local comp_total_income_value = digForComponent(cc_panel, "dy_sum_credit")
	comp_total_income_value:SetStateText(total_income)

	local total_index = expenditure_i > income_i and expenditure_i or income_i

	local new_hbar = find_uicomponent(cc_panel, "pj_hbar_2")
	move_rel(new_hbar, tx_income, 15, total_index*35+35+15+5)

	move_rel(tx_total_income, tx_income, 35, total_index*35+35+15)

	local tx_income_annual = digForComponent(cc_panel, "tx_income_annual")
	tx_income_annual:SetStateText("Profit")
	move_rel(tx_income_annual, tx_income, 35+200+65, total_index*35+35+15+100)

	local dy_annual_income = digForComponent(tx_income_annual, "dy_annual-income")
	dy_annual_income:SetDockOffset(150, 0)
	dy_annual_income:TextShaderTechniqueSet(0, true)

	local profit = total_income - total_price
	if total_income - total_price < 0 then
		dy_annual_income:SetStateText("[[col:red]]"..profit.."[[/col]]")
	else
		dy_annual_income:SetStateText(profit)
	end

	cm:treasury_mod(cm:get_local_faction(true), profit)

	move_rel(cc_panel, core:get_ui_root(), sw/2-cc_panel:Width()/2, sh/2-cc_panel:Height()/2)
	move_rel(parchment, cc_panel, 10, 80)

	local tab_summary = digForComponent(cc_panel, "tab_summary")
	tab_summary:SetVisible(false)
	local tab_trade = digForComponent(cc_panel, "tab_trade")
	tab_trade:SetVisible(false)

	local title = find_uicomponent(cc_panel, "panel_title", "tx_finance")
	title:SetStateText("Ledger")

	local exit_button = digForComponent(cc_panel, "pj_exit_button")
	if not exit_button then
		exit_button = UIComponent(cc_panel:CreateComponent("pj_exit_button", "ui/templates/round_medium_button"))
	end
	move_rel(exit_button, cc_panel, cc_panel:Width()/2-exit_button:Width()/2, cc_panel:Height()-exit_button:Height()/2)
	exit_button:SetImagePath("ui/skins/warhammer2/icon_check.png", 0)

	core:remove_listener('pj_unit_upgrades_on_clicked_retrain_button111')
	core:add_listener(
		'pj_unit_upgrades_on_clicked_retrain_button111',
		'ComponentLClickUp',
		function(context)
			return context.string == "pj_exit_button"
		end,
		function()
			local cc_panel = digForComponent(core:get_ui_root(), "pj_contract_completed_panel", 1)
			if not cc_panel then return end

			cc_panel:SetVisible(false)
			if payload_on_closed then
				payload_on_closed()
			end
		end,
		true
	)
end

mod.play_rite = function()
	local ui_root = core:get_ui_root()
	local rite = UIComponent(ui_root:CreateComponent("pj_srtrts", "ui/campaign ui/rite_performed"))
	for i = 0, rite:ChildCount() - 1 do
		local uic_child = UIComponent(rite:Find(i));
		uic_child:SetVisible(false)
	end;
	local wh2_main_def_hag_graef = digForComponent(rite, "wh2_main_def_hag_graef")
	wh2_main_def_hag_graef:SetVisible(true)
	for i = 0, wh2_main_def_hag_graef:ChildCount() - 1 do
		local uic_child = UIComponent(wh2_main_def_hag_graef:Find(i));
		if uic_child:Id() ~= "circle2" then
			uic_child:SetVisible(false)
		end
		if uic_child:Id() == "circle2" then
			uic_child:SetDockOffset(-30, 0)
		end
		if uic_child:Id() == "text_holder" then
			uic_child:SetVisible(true)
			local rite_text = find_uicomponent(uic_child, "tx_rite_reformed")
			if rite_text then
				rite_text:SetDockOffset(-15, 0)
				rite_text:SetStateText("Contract completed!")
			end
		end
	end
end
