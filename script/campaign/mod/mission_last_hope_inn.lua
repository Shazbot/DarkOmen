PJ_QUESTS = PJ_QUESTS or {}
local mod = PJ_QUESTS

mod.mission_last_hope_inn_payload = function(char)
end

mod.mission_last_hope_inn = {
	key = "mission_last_hope_inn",
	ui_offsets = {725+103, 425+35+2-90-24},
	locs = {
		title="LAST HOPE INN",
		desc="DESC",
		mission_desc = "MISSION DESC",
	},
	icon = "ui/small_city_schem_frame_major.png",
	payload = mod.mission_last_hope_inn_payload,
}
