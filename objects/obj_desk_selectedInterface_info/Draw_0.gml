mask_index = maskArr[obj_desk_camera.cameraDistance]
if obj_desk_selectedInterface_controller.selectedSomeone{
	if is_real(ds_map_find_value(obj_desk_map.figuresArr[obj_desk_selectedInterface_controller.selectedX,obj_desk_selectedInterface_controller.selectedY],"type")) == true{
		
			staticX = obj_desk_camera.x-(obj_desk_camera.sizeX/2-256)*obj_desk_camera.cameraDistance
			staticY = obj_desk_camera.y+(obj_desk_camera.sizeY/2-40)*obj_desk_camera.cameraDistance
			
			drawX = staticX-dinamicX
			drawY = staticY-dinamicY
		
			draw_sprite_ext(spr_character_info_stant,0,drawX,drawY,obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,0,noone,1)
			
			if tick < 20{
				dinamicY = obj_desk_selectedInterface_controller.scaleFunctionParametrs[0]*tick*tick+obj_desk_selectedInterface_controller.scaleFunctionParametrs[1]*tick+obj_desk_selectedInterface_controller.scaleFunctionParametrs[2]
				dinamicX = 0
				tick++
			}
			else{
				dinamicX = 0
				dinamicY = 0
			}
	}
	else{
		switch ds_map_find_value(obj_desk_map.figuresArr[obj_desk_selectedInterface_controller.selectedX,obj_desk_selectedInterface_controller.selectedY],"type"){
			case "town":{
		
			}
		}
	}
}