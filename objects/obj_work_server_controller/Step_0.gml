if gotoDesk == true{

	transitBuffer = buffer_create(256, buffer_grow, 1)
	buffer_seek(transitBuffer, buffer_seek_start, 0)
	buffer_write(transitBuffer, buffer_string, "Go To Desk")
	for (i = 0; i < ds_list_size(global.socketlist); i++){
		network_send_packet(ds_list_find_value(global.socketlist, i), transitBuffer, buffer_tell(transitBuffer))
	}
				
	buffer_delete(transitBuffer)
	
}