PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS


core:remove_listener("pj_quests_on_entered_sjoktraken")
core:add_listener(
	"pj_quests_on_entered_sjoktraken",
	"pj_quests_on_state_changed",
	function(context)
		local state = context.string
		return state == mod.states.in_sjok
	end,
	function(context)
		cm:callback(function()
			cm:trigger_dilemma("wh_main_emp_empire", "dilemma_enter_sjoktraken");
		end, 1)
	end,
	true
)

core:add_listener(
    "Enter_Sjoktraken_Dilemma_Resulting_Mission",
    "DilemmaChoiceMadeEvent",
    true,
    function(context)
            out("ZOID DilemmaChoiceMadeEvent");
            if context:dilemma() == "dilemma_enter_sjoktraken"
            then
                    if context:choice() == 0
                    then
                            cm:trigger_dilemma("wh_main_emp_empire", "dilemma_enter2_sjoktraken_mission_offer");
                    end;
                    if context:choice() == 1
                    then
                            cm:trigger_dilemma("wh_main_emp_empire", "dilemma_enter2_sjoktraken_mission_offer");
                    end;
            end;
    end,
    true
)
