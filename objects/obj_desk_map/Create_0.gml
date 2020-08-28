canDraw = false
for (i = 0; i <  ds_map_find_value(global.settingsGame,"mapSizeX"); i++){
	for (j = 0; j < ds_map_find_value(global.settingsGame,"mapSizeY"); j++){
		figuresArr[i,j] = -1
	}
}

// Указание сида для одинаковой генерации
seed = obj_desk_client_controller.workGenerateSeed
random_set_seed(seed)

// Генерация шума
for (i = 0; i <  ds_map_find_value(global.settingsGame,"mapSizeX"); i++){
	for (j = 0; j < ds_map_find_value(global.settingsGame,"mapSizeY"); j++){
		generate = random(1)
		if generate <= ds_map_find_value(global.settingsGame,"generateChanceAqua"){
			MapInfoArr[i,j] = 0
		}
		else{
			if generate <= ds_map_find_value(global.settingsGame,"generateChanceAqua")+ds_map_find_value(global.settingsGame,"generateChanceGrass"){
				MapInfoArr[i,j] = 2
			}
			else{
				if generate <= ds_map_find_value(global.settingsGame,"generateChanceAqua")+ds_map_find_value(global.settingsGame,"generateChanceGrass")+ds_map_find_value(global.settingsGame,"generateChanceMount"){
					MapInfoArr[i,j] = 4
				}
			}
		}
		MapBufferArr[i,j] = MapInfoArr[i,j]
	}
}

// Генерация координат базы
for(i = 0; i < ds_map_find_value(global.settingsGame,"generateHowPlayers"); i++){
	positionFree = false
	while positionFree == false{
		generateBasesPosition[i,0] = irandom_range(0,ds_map_find_value(global.settingsGame,"mapSizeX")-7) // positionX
		generateBasesPosition[i,1] = irandom_range(0,ds_map_find_value(global.settingsGame,"mapSizeY")-7) // positionY
		positionFree = true
		for(j = 0; j < i; j++){
			if !(abs(generateBasesPosition[i,0]-generateBasesPosition[j,0]) > 7 and abs(generateBasesPosition[i,1]-generateBasesPosition[j,1]) > 7){
				positionFree = false
				break
			}
		}
	}
	show_debug_message("Player"+string(i)+" Base X Position:"+string(generateBasesPosition[i,0]))
	show_debug_message("Player"+string(i)+" Base Y Position:"+string(generateBasesPosition[i,1]))	
}



// Сглаживание шума
for(z = 0; z < ds_map_find_value(global.settingsGame,"smoothingHowIteration"); z++){
	for (i = 0; i < ds_map_find_value(global.settingsGame,"mapSizeX"); i++){
		for (j = 0; j < ds_map_find_value(global.settingsGame,"mapSizeY"); j++){
			howAqua = 0
			howGrass = 0
			howMount = 0
			for(k = -1; k < 2; k++){
				for(l = -1; l < 2; l++){
					
					if scr_arguments_in_arrsize(MapBufferArr,i+k,j+l){
						
						switch MapBufferArr[i+k,j+l]{
							
							case 0:{
								howAqua++
								break
							}
							
							case 2:{
								howGrass++
								break
							}
							
							case 4:{
								howMount++
								break
							}
							
						}
						
					}	
					
				}
			}
			resultArr[0] = howAqua
			resultArr[1] = howGrass
			resultArr[2] = howMount
			MapInfoArr[i,j] = scr_max(resultArr)*2
		}
	}
	
	for (base = 0; base < ds_map_find_value(global.settingsGame,"generateHowPlayers"); base++){
		
		baseX = generateBasesPosition[base,0]
		baseY = generateBasesPosition[base,1]
		
		for (i = 0; i < 5; i++){
			for (j = 0; j < 5; j++){
				if scr_arguments_in_arrsize(MapInfoArr,i+baseX,j+baseY) == true{
					MapInfoArr[i+baseX,j+baseY] = 2
				}
			}
		}
		
	}
	
	for (i = 0; i < ds_map_find_value(global.settingsGame,"mapSizeX"); i++){
		for (j = 0; j < ds_map_find_value(global.settingsGame,"mapSizeY"); j++){
			MapBufferArr[i,j] = MapInfoArr[i,j]
		}
	}
	
}

// Создание леса, хребтов, глубокой воды
for (i = 0; i < ds_map_find_value(global.settingsGame,"mapSizeX"); i++){
	for (j = 0; j < ds_map_find_value(global.settingsGame,"mapSizeY"); j++){
		iniArr[i,j] = 0
		injArr[i,j] = 0
	}
}
		
for (i = 0; i < ds_map_find_value(global.settingsGame,"mapSizeX"); i++){
	for (j = 0; j < ds_map_find_value(global.settingsGame,"mapSizeY"); j++){
		scr_generate_forest(i,j,true)	
		scr_generate_range(i,j,true)
		scr_generate_deep(i,j)
	}
}


// Сглаживание
MapInfoArr = scr_bin_smoothing(MapInfoArr,ds_map_find_value(global.settingsGame,"mapSizeX"),ds_map_find_value(global.settingsGame,"mapSizeY"),2,3,5)
MapInfoArr = scr_bin_smoothing(MapInfoArr,ds_map_find_value(global.settingsGame,"mapSizeX"),ds_map_find_value(global.settingsGame,"mapSizeY"),4,5,5)

for (i = 0; i <  ds_map_find_value(global.settingsGame,"mapSizeX"); i++){
	for (j = 0; j < ds_map_find_value(global.settingsGame,"mapSizeY"); j++){
		cell = ds_map_create()
		ds_map_add(cell,"type",MapInfoArr[i,j])
		ds_map_add(cell,"animationStatus","none")
		ds_map_add(cell,"id",noone)
		ds_map_add(cell,"create",false)
		
		if MapInfoArr[i,j] > 1{
			if MapInfoArr[i,j] == 2{
				ds_map_add(cell,"fogOpen",0)
			}
			if MapInfoArr[i,j] == 3{
				ds_map_add(cell,"fogOpen",-1)
			}
			if MapInfoArr[i,j] == 4{
				ds_map_add(cell,"fogOpen",1)
			}
			if MapInfoArr[i,j] == 5{
				ds_map_add(cell,"fogOpen",2)
			}
		}
		
		if ds_map_find_value(global.settingsGame,"fogOfWar") == true{
			ds_map_add(cell,"fogStatus","close")
		}
		else{
			ds_map_add(cell,"fogStatus","open")
		}
		if MapInfoArr[i,j] > 1{
			ds_map_add(cell,"moveLose",MapInfoArr[i,j]-1)
		}
		else{
			ds_map_add(cell,"moveLose",999)
		}
		
		/*
		Анимационные Статусы:
			checkStep - наведение шаги
			checkAttack - наведение атаки
			pressStep - движение
			pressAttack - атака
			none
		*/
		
		cellsArr[i,j] = cell
	}
}

// Подтверждение генерации
obj_desk_client_controller.mapGenerated = true