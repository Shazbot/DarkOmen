-- move --
cm:move_to(cm:char_lookup_str(char), 696,635, true) -- move_mission_sjoktraken
cm:move_to(cm:char_lookup_str(char), 683,654, true) -- move_mission_kraka_drak
cm:move_to(cm:char_lookup_str(char), 655,637, true) -- move_mission_kraka_ravnsvake
-- mission -- 
cm:move_to(cm:char_lookup_str(char), 704,649, true) -- mission_sjoktraken_shipwreck
cm:move_to(cm:char_lookup_str(char), 679,635, true) -- mission_sjoktraken_the_last_hope_inn
cm:move_to(cm:char_lookup_str(char), 678,661, true) -- mission_kraka_drak_beastmen_camp
cm:move_to(cm:char_lookup_str(char), 676,668, true) -- mission_kraka_drak_chaos_warp
cm:move_to(cm:char_lookup_str(char), 660,658, true) -- mission_after_kraka_drak_mountain_pass
cm:move_to(cm:char_lookup_str(char), 671,636, true) -- mission_kraka_ravnsvake_fimir_bog
cm:move_to(cm:char_lookup_str(char), 643,630, true) -- mission_kraka_ravnsvake_icetrolls
--camera coordinates 
cm:scroll_camera_from_current(true, 0.1, {463.25170898438,492.07736206055, 5, d_to_r(120), 4}) -- ends sjoktraken
cm:scroll_camera_from_current(true, 0.1, {470.60491943359,500.95404052734, 5, d_to_r(120), 4}) -- ends at qb mission_sjoktraken_shipwreck
cm:scroll_camera_from_current(true, 0.1, {453.89309692383,490.53359985352, 5, d_to_r(120), 4}) -- ends at qb mission_sjoktraken_the_last_hope_inn
cm:scroll_camera_from_current(true, 0.1, {456.56698608398,505.19943237305, 5, d_to_r(120), 4}) -- ends kraka_drak
cm:scroll_camera_from_current(true, 0.1, {453.22460937535,510.21667480469, 5, d_to_r(120), 4}) -- ends at qb mission_kraka_drak_beastmen_camp
cm:scroll_camera_from_current(true, 0.1, {451.88766479492,515.61987304688, 5, d_to_r(120), 4}) -- ends at qb mission_kraka_drak_chaos_warp
cm:scroll_camera_from_current(true, 0.1, {441.19210815431,507.90103149414, 5, d_to_r(120), 4}) -- ends at qb mission_after_kraka_drak_mountain_pass
cm:scroll_camera_from_current(true, 0.1, {437.84973144531,492.07736206055, 5, d_to_r(120), 4}) -- ends at kraka_ravnsvake 
cm:scroll_camera_from_current(true, 0.1, {448.54531860352,491.30548095703, 5, d_to_r(120), 4}) -- ends at qb mission_kraka_ravnsvake_fimir_bog
cm:scroll_camera_from_current(true, 0.1, {429.82806396484,486.67416381836, 5, d_to_r(120), 4}) -- ends at qb mission_kraka_ravnsvake_icetrolls