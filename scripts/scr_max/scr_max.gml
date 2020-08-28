variables = argument0

maxes = []
howMaxes = 0
for(ini = 0; ini < array_length_1d(variables); ini++){
	isMax = true
	for(inj = 0; inj < array_length_1d(variables); inj++){
		
		if variables[ini] < variables[inj]{
			isMax = false
			break
		}
		
	}
	if isMax == true{
		maxes[howMaxes] = ini
		howMaxes++
	}
}


return maxes[irandom_range(0,howMaxes-1)]