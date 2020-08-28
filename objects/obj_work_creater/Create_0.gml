if global.playerStatus = "host"{
	instance_create_depth(x,y,0,obj_work_server_controller)
	instance_create_depth(x,y,0,obj_work_client_controller)
}
else{
	instance_create_depth(x,y,0,obj_work_client_controller)
}

instance_create_layer(obj_work_camera.x,obj_work_camera.y,"Interface",obj_task_manager)
instance_create_layer(obj_work_camera.x,obj_work_camera.y,"Interface",obj_work_draw_interface)