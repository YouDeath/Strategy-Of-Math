if global.playerStatus = "host"{
	instance_create_depth(x,y,0,obj_lobby_server_controller)
	instance_create_depth(x,y,0,obj_lobby_client_controller)
}
else{
	instance_create_depth(x,y,0,obj_lobby_client_controller)
}