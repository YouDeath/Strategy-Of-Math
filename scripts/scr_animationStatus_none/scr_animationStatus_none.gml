if is_array(obj_desk_mouse_controller.infoArr){
	for(i = 0; i < array_length_1d(obj_desk_mouse_controller.infoArr); i++){
		list = obj_desk_mouse_controller.infoArr[i]
		infoX = ds_list_find_value(list,0)
		infoY = ds_list_find_value(list,1)
		cell = obj_desk_map.cellsArr[infoX,infoY]
		ds_map_set(cell,"animationStatus","none")
		cellId = ds_map_find_value(cell,"id")
		if instance_exists(cellId){
			cellId.animationStatusUpdate = true
		}
		obj_desk_map.cellsArr[infoX,infoY] = cell
	}
	obj_desk_mouse_controller.infoArr = noone
}