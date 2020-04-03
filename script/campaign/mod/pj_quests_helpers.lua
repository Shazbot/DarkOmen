PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS

local digForComponent = mod.digForComponent

--- Enable the autoresolve button in quest battles.
--- It'll still appear disabled, but it can be clicked.
core:remove_listener("pj_quests_enable_qb_autoresolve")
core:add_listener(
	"pj_quests_enable_qb_autoresolve",
	"PanelOpenedCampaign",
	function(context)
		return context.string == "popup_pre_battle"
	end,
	function()
		cm:callback(function()
			local set_attack = digForComponent(core:get_ui_root(), "button_set_attack")
			if set_attack then
				local autoresolve = digForComponent(set_attack, "button_autoresolve")
				if autoresolve then
					autoresolve:SetDisabled(false)
					autoresolve:SetState("active")
				end
			end
		end, 0.1)
	end,
	true
)
