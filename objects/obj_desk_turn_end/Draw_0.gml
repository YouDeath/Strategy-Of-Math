if obj_desk_camera.interfaceNeedUpdate == true{
	x = obj_desk_camera.x-obj_desk_camera.sizeX*obj_desk_camera.cameraDistance/2+96*obj_desk_camera.cameraDistance
	y = obj_desk_camera.y-obj_desk_camera.sizeY*obj_desk_camera.cameraDistance/2+32*obj_desk_camera.cameraDistance
	interfaceNeedUpdate = false
}

if press == false{
	draw_sprite_ext(spr_end_turn,0,x,y,obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,0,noone,1)
}
else{
	draw_sprite_ext(spr_end_turn,1,x,y,obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,0,noone,1)
}
