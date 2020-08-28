positionX = argument0
positionY = argument1
firstly = argument2

if MapInfoArr[positionX,positionY] == 2 or MapInfoArr[positionX,positionY] == 3{
	if firstly == true{
		if random(1) < ds_map_find_value(global.settingsGame,"generateChanceForest"){
			MapInfoArr[positionX,positionY] = 3
			for(iniArr[positionX,positionY] = -1; iniArr[positionX,positionY] < 2; iniArr[positionX,positionY]++){
				for(injArr[positionX,positionY] = -1; injArr[positionX,positionY] < 2; injArr[positionX,positionY]++){
					
					if iniArr[positionX,positionY]*injArr[positionX,positionY] == 0 and !(iniArr[positionX,positionY] == 0 and injArr[positionX,positionY] == 0){
						
						if scr_arguments_in_arrsize(obj_desk_map.MapInfoArr,positionX+iniArr[positionX,positionY],positionY+injArr[positionX,positionY]) == true{
							scr_generate_forest(positionX+iniArr[positionX,positionY],positionY+injArr[positionX,positionY],false)
						}
						
					}
					
				}
			}
		}
	}
	else{
		
		if random(1) < ds_map_find_value(global.settingsGame,"generateChanceForestMore"){
			MapInfoArr[positionX,positionY] = 3
			for(iniArr[positionX,positionY] = -1; iniArr[positionX,positionY] < 2; iniArr[positionX,positionY]++){
				for(injArr[positionX,positionY] = -1; injArr[positionX,positionY] < 2; injArr[positionX,positionY]++){
					
					if iniArr[positionX,positionY]*injArr[positionX,positionY] == 0 and !(iniArr[positionX,positionY] == 0 and injArr[positionX,positionY] == 0){
						
						if scr_arguments_in_arrsize(obj_desk_map.MapInfoArr,positionX+iniArr[positionX,positionY],positionY+injArr[positionX,positionY]) == true{
							scr_generate_forest(positionX+iniArr[positionX,positionY],positionY+injArr[positionX,positionY],false)
						}
						
					}
					
				}
			}
		}
		
	}
}