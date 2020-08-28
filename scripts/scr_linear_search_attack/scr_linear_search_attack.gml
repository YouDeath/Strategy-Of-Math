startX = argument0
startY = argument1
radiusMin = argument2
radiusMax = argument3
status = argument4

if is_array(obj_desk_mouse_controller.infoArr){
	position = array_length_1d(obj_desk_mouse_controller.infoArr)
}
else{
	position = 0
}

positionFigures = 0

for (z = radiusMin; z < radiusMax+1; z++){
	for (i = 0; i < z+1; i++){
		j = z-i
		for(ini = -1; ini < 2; ini++){
			for(inj = -1; inj < 2; inj++){
				if ini*inj != 0{
					if scr_arguments_in_arrsize(obj_desk_map.MapInfoArr,startX+i*ini,startY+j*inj){
						if obj_desk_map.figuresArr[startX+i*ini,startY+j*inj] != -1{
							figureIn = obj_desk_map.figuresArr[startX+i*ini,startY+j*inj]
							if ds_map_find_value(figureIn,"player") != obj_desk_client_controller.myNum{
								ds_map_set(figureIn,"inAttack",true)
								obj_desk_map.figuresArr[startX+i*ini,startY+j*inj] = figureIn
								listId = ds_list_create()
								ds_list_add(listId,startX+i*ini)
								ds_list_add(listId,startY+j*inj)
								obj_desk_mouse_controller.infoFiguresArr[positionFigures] = listId
								positionFigures++
								figureInId = ds_map_find_value(figureIn,"id")
								if instance_exists(figureInId){
									figureInId.animationStatusUpdate = true
								}
							}
						}
						else{
							cell = obj_desk_map.cellsArr[startX+i*ini,startY+j*inj]
							ds_map_set(cell,"animationStatus",status)
							obj_desk_map.cellsArr[startX+i*ini,startY+j*inj] = cell
							listId = ds_list_create()
							ds_list_add(listId,startX+i*ini)
							ds_list_add(listId,startY+j*inj)
							obj_desk_mouse_controller.infoArr[position] = listId
							position++
							cellId = ds_map_find_value(cell,"id")
							if instance_exists(cellId){
								cellId.animationStatusUpdate = true
							}
						}
					}
				}
			}
		}
	}
}