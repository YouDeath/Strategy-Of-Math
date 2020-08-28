arr = argument0
SizeX = argument1
SizeY = argument2
parFirst = argument3
parSecond = argument4
howIteration = argument5

for (i = 0; i < SizeX; i++){
	for (j = 0; j < SizeY; j++){
		arrBuff[i,j] = arr[i,j]
	}
}

for(z = 0; z < howIteration; z++){
	for (i = 0; i < SizeX; i++){
		for (j = 0; j < SizeY; j++){
			howFirst = 0
			howSecond = 0 
			for(k = -1; k < 2; k++){
				for(l = -1; l < 2; l++){
					
					if scr_arguments_in_arrsize(arr,i+k,j+l){
						
						if arrBuff[i+k,j+l] == parFirst{
							howFirst++
						}
						
						if arrBuff[i+k,j+l] == parSecond{
							howSecond++
						}
						
					}	
					
				}
			}
			if arrBuff[i,j] == parSecond{
				if howFirst > 5{
					arr[i,j] = parFirst
				}
			}
			else{
				if arrBuff[i,j] == parFirst{
					if howSecond > 3{
						arr[i,j] = parSecond
					}
				}
			}
		}
	}
	
	for (i = 0; i < SizeX; i++){
		for (j = 0; j < SizeY; j++){
			arrBuff[i,j] = arr[i,j]
		}
	}
	
}

return arr