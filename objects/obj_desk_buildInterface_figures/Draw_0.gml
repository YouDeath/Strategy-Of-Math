image_index = type
staticX = obj_desk_camera.x+(obj_desk_camera.sizeX/2-160-type*48)*obj_desk_camera.cameraDistance
staticY = obj_desk_camera.y+(obj_desk_camera.sizeY/2-48-(type mod 2)*48)*obj_desk_camera.cameraDistance

if obj_desk_buildInterface_controller.buildInterfaceOpen == true{

	if initialized == false{
		drawX = drawX-(drawX-staticX)/4
		drawY = staticY
		if (drawX-staticX)/4 < 1{
			initialized = true
		}
		x = staticX
		y = staticY
	}
	else{
		if selected == true{
			result = scr_dinamic_change_transparency(dinamicY,status,0.5*obj_desk_camera.cameraDistance,0,10*obj_desk_camera.cameraDistance)
			dinamicY = ds_map_find_value(result,"transparency")
			status = ds_map_find_value(result,"status")
		}
		else{
			if dinamicY > 0{
				dinamicY-=1*obj_desk_camera.cameraDistance
			}
		}
		drawX = staticX
		drawY = staticY-dinamicY
		x = staticX
		y = staticY
	}
	
}
else{

	drawX = drawX+(obj_desk_buildInterface_controller.x-drawX)/4
	drawY = staticY
	if tick = 3{
		instance_destroy()
	}
	x = staticX
	y = staticY
	tick++
	
}

draw_sprite_ext(spr_build_figures_stand,0,drawX,drawY,obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,0,noone,1)
draw_sprite_ext(spr_desk_figures,type,drawX,drawY,obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,0,noone,1)
