startX = argument0
startY = argument1
radius = argument2
status = argument3
	
for (i = 0; i < radius*2+2; i++){
	for (j = 0; j < radius*2+2; j++){
		stepIteratorPosition[i,j] = 1000
	}
}

if is_array(obj_desk_mouse_controller.infoArr){
	position = array_length_1d(obj_desk_mouse_controller.infoArr)
}
else{
	position = 0
}


stepIteratorPosition[radius+1,radius+1] = 0

for(z = 0; z < radius; z++){
	
	for (i = 0; i < radius*2+2; i++){
		for (j = 0; j < radius*2+2; j++){
			if stepIteratorPosition[i,j] == z{
				for(ini = -1; ini < 2; ini++){
					for(inj = -1; inj < 2; inj++){
						if scr_arguments_in_arrsize(stepIteratorPosition,ini+i,inj+j) and scr_arguments_in_arrsize(obj_desk_map.cellsArr,i-radius-1+ini+startX,j-radius-1+inj+startY) and !(ini == 0 and inj == 0) and (ini == 0 or inj == 0){
							canMove = false
							if obj_desk_map.figuresArr[i-radius-1+ini+startX,j-radius-1+inj+startY] == -1{
								canMove = true
							}
							else{
								figureIn = obj_desk_map.figuresArr[i-radius-1+ini+startX,j-radius-1+inj+startY]
								player = ds_map_find_value(figureIn,"player")
								if player == obj_desk_client_controller.myNum{
									canMove = true
								}
							}
							if canMove == true{
								cell = obj_desk_map.cellsArr[i-radius-1+ini+startX,j-radius-1+inj+startY]
								steplose = ds_map_find_value(cell,"moveLose")
								if z+steplose < stepIteratorPosition[i+ini,j+inj]{
									stepIteratorPosition[i+ini,j+inj] = z+steplose
									if stepIteratorPosition[i+ini,j+inj] != 0 and stepIteratorPosition[i+ini,j+inj] < 999{
										cellId = ds_map_find_value(cell,"id")
										if instance_exists(cellId){
											cellId.animationStatusUpdate = true
										}
										ds_map_set(cell,"animationStatus",status)
										obj_desk_map.cellsArr[i-radius-1+ini+startX,j-radius-1+inj+startY] = cell
										listId = ds_list_create()
										ds_list_add(listId,i-radius-1+ini+startX)
										ds_list_add(listId,j-radius-1+inj+startY)
										obj_desk_mouse_controller.infoArr[position] = listId
										position++
									}
								}
							}
						}
					}
				}
			
			}
		}
	}	
}
