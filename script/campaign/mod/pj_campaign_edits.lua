cm:add_first_tick_callback(function()
	local r = cm:get_region("wh_main_gianthome_mountains_khazid_bordkarag")
	if r and not r:is_null_interface() then
		cm:change_custom_settlement_name(r:settlement(), "Kraka Ravnsake")
	end
end)
