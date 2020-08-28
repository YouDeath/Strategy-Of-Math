if collision_point(mouse_x,mouse_y,obj_desk_layer_parent_interface,true,true) != noone{
	typeOfSelectedObject = "interface"
}
else{
	if collision_point(mouse_x,mouse_y,obj_desk_layer_parent_figures,true,true) != noone{
		typeOfSelectedObject = "figure"
	}
	else{
		if collision_point(mouse_x,mouse_y,obj_desk_layer_parent_cells,true,true) != noone{
			typeOfSelectedObject = "cell"
		}
	}
}

if typeOfSelectedObject != noone{

	switch typeOfSelectedObject{
		
		case "interface":{
			idOfSelectedObject = collision_point(mouse_x,mouse_y,obj_desk_layer_parent_interface,true,true)
			break
		}
		case "cell":{
			idOfSelectedObject = collision_point(mouse_x,mouse_y,obj_desk_layer_parent_cells,true,true)
			break
		}
		case "figure":{
			figures = ds_list_create()
			figureMinValue = 500
			figureMinId = noone
			how = collision_point_list(mouse_x,mouse_y,obj_desk_layer_parent_figures,true,true,figures,true)
			for(i = 0; i < how; i++){
				figureId = ds_list_find_value(figures,i)
				if figureMinValue > figureId.depth{
					figureMinValue = figureId.depth
					figureMinId = figureId
				} 
			}
			idOfSelectedObject = figureMinId
			break
		}
		
	}

}