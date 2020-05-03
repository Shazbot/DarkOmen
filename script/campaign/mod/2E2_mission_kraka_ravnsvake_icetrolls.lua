PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS

local mission_key = "mission_kraka_ravnsvake_icetrolls"

local payload = function(char)
	cm:callback(function()
		CampaignUI.ToggleCinematicBorders(true)
		cm:stop_user_input(true)
		cm:scroll_camera_from_current(true, 0.1, {455.23, 504.43, 5, d_to_r(120), 4})

		cm:callback(function()
			cm:move_to(cm:char_lookup_str(char), 643, 630, true) 
		end, 0.5)

		cm:scroll_camera_from_current(
			true, 4,
			{453.22, 510.21, 5, d_to_r(120), 4},
			{441.88, 507.61, 5, d_to_r(120), 4}
		)

		cm:callback(function()
			CampaignUI.ToggleCinematicBorders(false)
			cm:stop_user_input(false)
			mod.select_first_lord()
			mod.force_start_quest_battle("mission_kraka_ravnsvake_icetrolls")
		end, 5)
	end, 0.1)
end

mod[mission_key] = {
	key = mission_key,
	ui_offsets = {700, 425},
	locs = {
		title="Glacier Cleansing",
		desc="Glacier Cleansing",
		mission_desc = " The Gianthome mountains have become increasingly harder to travel for both mining parties and merchants alike. The main road towards Grung Trakekarag has been blocked for months by a small host of Ice Troll, whom have settled a glacier close to the main passageway.The mountain Rangers commander Sigmund Tranesong are in need of warriors, that can cleanse the land of these vile Ice Trolls. He offers to place a retinue of rangers at our free disposal for the trip to Kislev, if we are to eliminate the Ice Trolls",
	},
	icon = "ui/small_city_schem_frame_major.png",
	payload = payload,
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