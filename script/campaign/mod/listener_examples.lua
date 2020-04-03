PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS

--- Listener for a state change.
core:remove_listener("pj_quests_on_state_changed_example")
core:add_listener(
	"pj_quests_on_state_changed_example",
	"pj_quests_on_state_changed",
	true,
	function(context)
		---@type string
		local state = context.string
		out("changed to state "..tostring(state))
	end,
	true
)

--- Listeners when winning or losing a battle. ---
core:remove_listener("pj_quests_on_won_battle_shipwreck_example")
core:add_listener(
	"pj_quests_on_won_battle_shipwreck_example",
	"pj_quests_won_battle_shipwreck",
	true,
	function()
		out("WON SHIPWRECK")
	end,
	true
)

core:remove_listener("pj_quests_on_lost_battle_shipwreck_example")
core:add_listener(
	"pj_quests_on_lost_battle_shipwreck_example",
	"pj_quests_lost_battle_shipwreck",
	true,
	function()
		out("LOST SHIPWRECK")
	end,
	true
)
