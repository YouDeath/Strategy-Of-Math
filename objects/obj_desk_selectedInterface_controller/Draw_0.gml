if selectedSomeone == true{
	if is_real(ds_map_find_value(obj_desk_map.figuresArr[selectedX,selectedY],"type")) == true{
		typeFigure = ds_map_find_value(obj_desk_map.figuresArr[selectedX,selectedY],"type")
		typeCell = obj_desk_map.MapInfoArr[selectedX,selectedY]
		
		staticX = obj_desk_camera.x-(obj_desk_camera.sizeX/2-84)*obj_desk_camera.cameraDistance
		staticY = obj_desk_camera.y+(obj_desk_camera.sizeY/2-84)*obj_desk_camera.cameraDistance
			
		drawX = staticX-dinamicX
		drawY = staticY-dinamicY
		
		draw_sprite_ext(spr_character_stand,0,drawX,drawY,obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,0,noone,1)
		draw_sprite_ext(spr_town_stand,1,drawX,drawY-6*obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,0,noone,1)
		draw_sprite_ext(spr_desk_cells,typeCell,drawX,drawY-12*obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,0,noone,1)
		draw_sprite_ext(spr_desk_figures,typeFigure,drawX,drawY-12*obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,0,obj_desk_client_controller.playersColorArr[ds_map_find_value(obj_desk_map.figuresArr[selectedX,selectedY],"player")],1)
			
		if tick < 20{
			dinamicY = scaleFunctionParametrs[0]*tick*tick+scaleFunctionParametrs[1]*tick+scaleFunctionParametrs[2]
			dinamicX = 0
			tick++
		}
		else{
			dinamicX = 0
			dinamicY = 0
		}
	}
	else{
		switch ds_map_find_value(obj_desk_map.figuresArr[selectedX,selectedY],"type"){
			case "base center":{
		
				staticX = obj_desk_camera.x-(obj_desk_camera.sizeX/2-84)*obj_desk_camera.cameraDistance
				staticY = obj_desk_camera.y+(obj_desk_camera.sizeY/2-84)*obj_desk_camera.cameraDistance
			
				drawX = staticX-dinamicX
				drawY = staticY-dinamicY
		
				draw_sprite_ext(spr_character_stand,0,drawX,drawY,obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,0,noone,1)
				draw_sprite_ext(spr_town_stand,1,drawX,drawY-6*obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,0,noone,1)
				draw_sprite_ext(spr_town,0,drawX,drawY,obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,0,noone,1)
				draw_sprite_ext(spr_town,1,drawX,drawY,obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,0,obj_desk_client_controller.playersColorArr[ds_map_find_value(obj_desk_map.figuresArr[selectedX,selectedY],"player")],1)
			
				if tick < 20{
					dinamicY = scaleFunctionParametrs[0]*tick*tick+scaleFunctionParametrs[1]*tick+scaleFunctionParametrs[2]
					dinamicX = 0
					tick++
				}
				else{
					dinamicX = 0
					dinamicY = 0
				}
				break
			}
		}
	}
}