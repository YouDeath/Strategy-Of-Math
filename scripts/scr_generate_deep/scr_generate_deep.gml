positionX = argument0
positionY = argument1

if MapInfoArr[positionX,positionY] == 0{
	how = 0
	for(iniArr[positionX,positionY] = -1; iniArr[positionX,positionY] < 2; iniArr[positionX,positionY]++){
		for(injArr[positionX,positionY] = -1; injArr[positionX,positionY] < 2; injArr[positionX,positionY]++){
			

				if scr_arguments_in_arrsize(obj_desk_map.MapInfoArr,positionX+iniArr[positionX,positionY],positionY+injArr[positionX,positionY]) == true{
					if MapInfoArr[positionX+iniArr[positionX,positionY],positionY+injArr[positionX,positionY]] == 1 or MapInfoArr[positionX+iniArr[positionX,positionY],positionY+injArr[positionX,positionY]] == 0{
						how++
					}
				}
				else{
					how++
				}

			if how == 8{
				MapInfoArr[positionX,positionY] = 1
			}
			
		}
	}
	
}