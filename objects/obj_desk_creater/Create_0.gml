if global.playerStatus = "host"{
	instance_create_layer(x,y,"Service",obj_desk_server_controller)
	instance_create_layer(x,y,"Service",obj_desk_client_controller)
}
else{
	instance_create_layer(x,y,"Service",obj_desk_client_controller)
}