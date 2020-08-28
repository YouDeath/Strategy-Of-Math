if needRender == true{
	needRender = false
	
	// Очистка
	with obj_desk_cell{
		instance_destroy()
	}
	with obj_desk_figure{
		instance_destroy()
	}
	with obj_desk_town{
		instance_destroy()
	}

	create_par = 4
	layerX = x div (36+create_par)
	layerY = y div (36+create_par)
	renderLayerX = (sizeX*cameraDistance/2) div 32 
	renderLayerY = (sizeY*cameraDistance/2) div 32 

	if rendering == true{
		// Рендеринг
		for(i = 0; i < ds_map_find_value(global.settingsGame,"mapSizeX"); i++){
			for(j = max(0,layerY-renderLayerY-i); j < min(ds_map_find_value(global.settingsGame,"mapSizeY"),layerY+renderLayerY-i); j++){
				
				if i-j > layerX-renderLayerX and i-j < layerX+renderLayerX{
					createX = (36+create_par)*(i-j)
					createY = i*(36+create_par)+j*(36+create_par)
					cellID = instance_create_layer(createX,createY,"IngameCells",obj_desk_cell)
					cell = obj_desk_map.cellsArr[i,j]
					ds_map_set(cell,"id",cellID)
					obj_desk_map.cellsArr[i,j] = cell
					
					if obj_desk_map.figuresArr[i,j] != -1{
						cellID.empty = false
					}
					else{
						cellID.empty = true
					}
					
					cellID.type = obj_desk_map.MapInfoArr[i,j]
					cellID.positionX = i
					cellID.positionY = j
					
					// Рендеринг фигур
					if cellID.empty = false and ds_map_find_value(cell,"fogStatus") == "open"{
						figure = obj_desk_map.figuresArr[i,j]
						figureType = ds_map_find_value(figure,"type")
						if is_real(figureType){
							figureId = instance_create_layer(createX,createY,"IngameFigures",obj_desk_figure)
							figureId.owner = ds_map_find_value(figure,"player")
							figureId.type = figureType
							figureId.positionX = i
							figureId.positionY = j
							if ds_map_find_value(figure,"selected"){
								figureId.selected = true
								figureId.transparencyResult = scr_dinamic_change_transparency(1,"Down",0.04,0,1)
								obj_desk_selectedInterface_controller.selectedId = figureId
							}
							figureId.depth = layer_get_depth(layer_get_id("IngameCells"))-i-j
							
							ds_map_set(obj_desk_map.figuresArr[i,j],"id",figureId)
						}
						else{
							switch figureType{
								case "base center":{
									
									figureId = instance_create_layer(createX,createY,"IngameFigures",obj_desk_town)
									
									figureId.color = obj_desk_client_controller.playersColorArr[ds_map_find_value(figure,"player")]
									figureId.owner =  ds_map_find_value(figure,"player")
									figureId.positionX = i
									figureId.positionY = j
									if ds_map_find_value(figure,"selected"){
										figureId.selected = true
										figureId.transparencyResult = scr_dinamic_change_transparency(1,"Down",0.04,0,1)
										obj_desk_selectedInterface_controller.selectedId = figureId
									}
									figureId.depth = layer_get_depth(layer_get_id("IngameCells"))-i-j
									ds_map_set(obj_desk_map.figuresArr[i,j],"id",figureId)
									
									break
								}
								case "base additional":{
									break
								}
							}
						}
					}
				}
			
			}
		}
	
	}
	
	backX = x
	backY = y
}


/*
create_par = 3
layerX = x div (36+create_par)
layerY = y div (36+create_par)
renderLayerX = (sizeX/2) div 32
renderLayerY = (sizeY/2) div 32 

for(i = 0; i < ds_map_find_value(global.settingsGame,"mapSizeY"); i++){
	for(j = 0; j < ds_map_find_value(global.settingsGame,"mapSizeY"); j++){
		drawX = (36+create_par)*(i-j)
		drawY = i*(36+create_par)+j*(36+create_par)
		cellID = instance_create_depth(drawX,drawY,0,obj_desk_cell)
		cellID.type = obj_desk_map.MapInfoArr[i,j]
	}
}
*/

