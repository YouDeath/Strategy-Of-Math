if is_array(obj_desk_mouse_controller.infoFiguresArr){
	for(i = 0; i < array_length_1d(obj_desk_mouse_controller.infoFiguresArr); i++){
		list = obj_desk_mouse_controller.infoFiguresArr[i]
		infoX = ds_list_find_value(list,0)
		infoY = ds_list_find_value(list,1)
		if is_real(infoX) and is_real(infoY){
			figureIn = obj_desk_map.figuresArr[infoX,infoY]
			if figureIn != -1{
				ds_map_set(figureIn,"inAttack",false)
				figureInId = ds_map_find_value(figureIn,"id")
				if instance_exists(figureInId){
					figureInId.animationStatusUpdate = true
				}
				obj_desk_map.figuresArr[infoX,infoY] = figureIn
			}
		}
	}
	obj_desk_mouse_controller.infoFiguresArr = noone
}