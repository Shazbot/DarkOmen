PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS

mod.move_mission_kraka_drak_payload = function(char)
end

mod.move_mission_kraka_drak = {
	key = "move_mission_kraka_drak",
	ui_offsets = {725, 425+35+2-90-24},
	locs = {
		title="KRAKA DRAK",
		desc="DESC",
		mission_desc = "MISSION DESC",
	},
	icon = "ui/small_city_schem_frame_major.png",
	payload = mod.move_mission_kraka_drak_payload,
}
