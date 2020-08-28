renderX = argument0
renderY = argument1
size = 7

for(i = max(0,renderX-size-7); i < min(ds_map_find_value(global.settingsGame,"mapSizeX"),renderX+size+7); i++){
	for(j = max(0,renderY-size-7); j < min(ds_map_find_value(global.settingsGame,"mapSizeY"),renderY+size+7); j++){
		if obj_desk_map.figuresArr[i,j] != -1{
			figure = obj_desk_map.figuresArr[i,j]
			if ds_map_find_value(figure,"player") == obj_desk_client_controller.myNum{
				cell = obj_desk_map.cellsArr[i,j]
				fogOpen = ds_map_find_value(figure,"fogOpen")+ds_map_find_value(cell,"fogOpen")
				for (ini = -fogOpen; ini < fogOpen+1; ini++){
					for(inj = -fogOpen; inj < fogOpen+1; inj++){
						if scr_arguments_in_arrsize(obj_desk_map.cellsArr,i+ini,j+inj){
							ds_map_set(obj_desk_map.cellsArr[i+ini,j+inj],"fogStatus","open")
						}
					}
				}
			}
		}
	}
}