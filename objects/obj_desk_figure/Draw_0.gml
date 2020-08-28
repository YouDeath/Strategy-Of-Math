image_index = type

if animationStatusUpdate == true{
	figure = obj_desk_map.figuresArr[positionX,positionY]
	inAttack = ds_map_find_value(figure,"inAttack")
	if inAttack == true{
		transparencyResult = scr_dinamic_change_transparency(1,"Down",0.04,0,1)
	}
	animationStatusUpdate = false
}

if initialized == false{
	draw_x = x+(draw_x-x)/2
	draw_y = y+(draw_y-y)/2
	if point_distance(x,y,draw_x,draw_y) < 1{
		initialized = true
	}
	draw_sprite_ext(spr_desk_figures,type,draw_x,draw_y,1,1,0,obj_desk_client_controller.playersColorArr[owner],1)
}
else{
	draw_sprite_ext(spr_desk_figures,type,x,y,1,1,0,obj_desk_client_controller.playersColorArr[owner],1)
	
	if selected == true{
		transparencyDinamic = ds_map_find_value(transparencyResult,"transparency")
		draw_sprite_ext(spr_desk_figures,type+9,x,y,1,1,0,noone,transparencyDinamic)
		transparencyStatus = ds_map_find_value(transparencyResult,"status")
		transparencyResult = scr_dinamic_change_transparency(transparencyDinamic,transparencyStatus,0.04,0,1)
	}
	else{
		if inAttack == false{
			if obj_desk_mouse_controller.idOfSelectedObject == id{
				draw_sprite(spr_desk_figures,type+9,x,y)
			}
		}
		if inAttack == true{
			transparencyDinamic = ds_map_find_value(transparencyResult,"transparency")
			draw_sprite_ext(spr_desk_figures,type+18,x,y,1,1,0,c_white,transparencyDinamic)
			transparencyStatus = ds_map_find_value(transparencyResult,"status")
			transparencyResult = scr_dinamic_change_transparency(transparencyDinamic,transparencyStatus,0.02,0,1)
		}
	}
}