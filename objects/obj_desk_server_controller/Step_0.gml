if part == "start"{
	allGenerate = true
	for(i = 0; i < ds_list_size(global.socketlist); i++){
		if isGenerate[i] = false{
			allGenerate = false
			break;
		}
	}
	
	transitBuffer = buffer_create(256, buffer_grow, 1)
	buffer_seek(transitBuffer, buffer_seek_start, 0)
	buffer_write(transitBuffer, buffer_string, "Players Colours")
	buffer_write(transitBuffer, buffer_s8, ds_list_size(global.socketlist))
	for(i = 0; i < ds_list_size(global.socketlist); i++){
		buffer_write(transitBuffer, buffer_s16, colors[i,0])
		buffer_write(transitBuffer, buffer_s16, colors[i,1])
		buffer_write(transitBuffer, buffer_s16, colors[i,2])
	}
	
	for(i = 0; i < ds_list_size(global.socketlist); i++){
		network_send_packet(ds_list_find_value(global.socketlist, i), transitBuffer, buffer_tell(transitBuffer))
	}		
	buffer_delete(transitBuffer)	
	
	if allGenerate == true{
		part = "distribution"
	}
}
if part == "distribution"{
	for(i = 0; i < ds_list_size(global.socketlist); i++){
		transitBuffer = buffer_create(256, buffer_grow, 1)
		buffer_seek(transitBuffer, buffer_seek_start, 0)
		buffer_write(transitBuffer, buffer_string, "Number In Game")
		buffer_write(transitBuffer, buffer_s8, i)
		
		network_send_packet(ds_list_find_value(global.socketlist, i), transitBuffer, buffer_tell(transitBuffer))
				
		buffer_delete(transitBuffer)	
	}
	part = "ingame"
}