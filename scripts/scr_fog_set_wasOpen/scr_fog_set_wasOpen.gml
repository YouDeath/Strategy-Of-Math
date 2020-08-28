renderX = argument0
renderY = argument1

figure = obj_desk_map.figuresArr[renderX,renderY]
cell = obj_desk_map.cellsArr[renderX,renderY]

fogOpen = ds_map_find_value(figure,"fogOpen")+ds_map_find_value(cell,"fogOpen")

for (ini = -fogOpen; ini < fogOpen+1; ini++){
	for(inj = -fogOpen; inj < fogOpen+1; inj++){
		if scr_arguments_in_arrsize(obj_desk_map.cellsArr,renderX+ini,renderY+inj){
			ds_map_set(obj_desk_map.cellsArr[renderX+ini,renderY+inj],"fogStatus","wasOpen")
		}
	}
}