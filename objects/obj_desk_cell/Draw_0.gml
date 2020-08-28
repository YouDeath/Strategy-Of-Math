cell = obj_desk_map.cellsArr[positionX,positionY]

if empty == true{
	if animationStatusUpdate == true{
		cell = obj_desk_map.cellsArr[positionX,positionY]
		animationStatus = ds_map_find_value(cell,"animationStatus")
		switch animationStatus{
			case "pressStep":{
				draw_sprite_ext(spr_desk_cells,8,x,y,1,1,0,obj_desk_client_controller.selectedColor,1)
				break
			}
			case "pressAttack":{
				draw_sprite_ext(spr_desk_cells,9,x,y,1,1,0,obj_desk_client_controller.selectedColor,1)
				break
			}
			case "howerStep":{
				transparencyResult = scr_dinamic_change_transparency(1,"Down",0.04,0,1)
				draw_sprite_ext(spr_desk_cells,8,x,y,1,1,0,obj_desk_client_controller.pressColor,1)
				break
			}
			case "howerAttack":{
				transparencyResult = scr_dinamic_change_transparency(1,"Down",0.04,0,1)
				draw_sprite_ext(spr_desk_cells,9,x,y,1,1,0,obj_desk_client_controller.pressColor,1)
				break
			}
		}
		animationStatusUpdate = false
	}
}

fogStatus = ds_map_find_value(cell,"fogStatus")

if fogStatus == "open"{
	draw_sprite(spr_desk_cells,type,x,y)
	switch animationStatus{
		case "pressStep":{
			draw_sprite_ext(spr_desk_cells,8,x,y,1,1,0,obj_desk_client_controller.selectedColor,1)
			break
		}
		case "pressAttack":{
			draw_sprite_ext(spr_desk_cells,9,x,y,1,1,0,obj_desk_client_controller.selectedColor,1)
			break
		}
		case "howerStep":{
			transparencyDinamic = ds_map_find_value(transparencyResult,"transparency")
			draw_sprite_ext(spr_desk_cells,8,x,y,1,1,0,obj_desk_client_controller.pressColor,transparencyDinamic)
			transparencyStatus = ds_map_find_value(transparencyResult,"status")
			transparencyResult = scr_dinamic_change_transparency(transparencyDinamic,transparencyStatus,0.04,0,1)
			break
		}
		case "howerAttack":{
			transparencyDinamic = ds_map_find_value(transparencyResult,"transparency")
			draw_sprite_ext(spr_desk_cells,9,x,y,1,1,0,obj_desk_client_controller.pressColor,transparencyDinamic)
			transparencyStatus = ds_map_find_value(transparencyResult,"status")
			transparencyResult = scr_dinamic_change_transparency(transparencyDinamic,transparencyStatus,0.04,0,1)
			break
		}
	}
}
else{
	if fogStatus == "wasOpen"{
		draw_sprite(spr_desk_cells,type,x,y)
		draw_sprite_ext(spr_desk_cells,10,x,y-4,1,1,0,noone,1)
	}
	else{
		if fogStatus == "close"{
			draw_sprite(spr_desk_cells,6,x,y)
		}
	}
}

