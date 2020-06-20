PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS

local mission_key = "mission_kraka_ravnsvake_icetrolls"

-- this is the starting char and camera position
-- local char = cm:get_faction(cm:get_local_faction(true)):faction_leader()
-- cm:scroll_camera_from_current(true, 0.1, {437.8497, 492.077, 8, d_to_r(120), 4})
-- cm:teleport_to(cm:char_lookup_str(char), 655, 637, false)

local payload = function(char)
	cm:callback(function()
		CampaignUI.ToggleCinematicBorders(true)
		cm:stop_user_input(true)
		cm:scroll_camera_from_current(true, 0.1, {437.8497, 492.077, 8, d_to_r(120), 4})

		cm:callback(function()
			cm:move_to(cm:char_lookup_str(char), 643, 630, true) -- moving to Kislev
		end, 0.5)

		cm:scroll_camera_from_current(
			true, 3.5,
			{429.828, 486.674, 5, d_to_r(120), 4}
		)

		cm:callback(function()
			CampaignUI.ToggleCinematicBorders(false)
			cm:stop_user_input(false)
			mod.select_first_lord()
			mod.force_start_quest_battle("mission_kraka_ravnsvake_icetrolls")
		end, 4.5)
	end, 0.1)
end

mod[mission_key] = {
	key = mission_key,
	ui_offsets = {218, 383},
	ui_pivot = "top",
	locs = {
		title="Glacier Cleansing",
		desc="Glacier Cleansing",
		mission_desc = " The Gianthome mountains have become increasingly harder to travel for both mining parties and merchants alike. The main road towards Grung Trakekarag has been blocked for months by a small host of Ice Troll, whom have settled a glacier close to the main passageway.The mountain Rangers commander Sigmund Tranesong are in need of warriors, that can cleanse the land of these vile Ice Trolls. He offers to place a retinue of rangers at our free disposal for the trip to Kislev, if we are to eliminate the Ice Trolls",
	},
	icon = "ui/small_city_schem_frame_major.png",
	payload = payload,
	condition = function() return not cm:get_saved_value("pj_quests_ice_trolls_completed") end,
}

core:remove_listener("pj_quests_on_won_battle_icetrolls")
core:add_listener(
	"pj_quests_on_won_battle_icetrolls",
	"pj_quests_won_battle_icetrolls",
	true,
	function()
		mod.set_state(mod.states.after_ice_trolls)
	end,
	true
)
