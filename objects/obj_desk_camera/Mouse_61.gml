cameraDistance+=1
if cameraDistance > 2{
	cameraDistance = 2
}
else{

	if obj_desk_client_controller.menuOpen == false{

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
									ds_map_set(obj_desk_map.figuresArr[i,j],"id",figureId)
									
									if ds_map_find_value(figure,"selected"){
										figureId.selected = true
										figureId.transparencyResult = scr_dinamic_change_transparency(1,"Down",0.04,0,1)
										obj_desk_selectedInterface_controller.selectedId = figureId
									}
									figureId.depth = layer_get_depth(layer_get_id("IngameCells"))-i-j
									
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

		pm = matrix_build_projection_ortho(sizeX*cameraDistance, sizeY*cameraDistance, 1, 10000)
		camera_set_proj_mat(camera, pm)
	
		instance_destroy(obj_desk_menu)
		object_set_mask(obj_desk_menu,maskArr[cameraDistance])
		instance_create_layer(x,y,"Interface",obj_desk_menu)
		
		if instance_exists(obj_desk_turn_end){
			instance_destroy(obj_desk_turn_end)
			object_set_mask(obj_desk_turn_end,maskArr[cameraDistance+3])
			instance_create_layer(x,y,"Interface",obj_desk_turn_end)
		}

		if obj_desk_selectedInterface_controller.controllerId != 0{
			buildInterfaceStatus = obj_desk_buildInterface_controller.buildInterfaceOpen
			selectedId = obj_desk_buildInterface_controller.selectedId
			type = -1
			if selectedId != 0{
				type = selectedId.type
				dinamicY = selectedId.dinamicY/(cameraDistance+1)
			}
			/*
			instance_destroy(obj_desk_buildInterface_controller)
			object_set_mask(obj_desk_buildInterface_controller,maskArr[cameraDistance+6])
			controllerId = instance_create_layer(x,y,"Interface",obj_desk_buildInterface_controller)
			controllerId.buildInterfaceOpen = buildInterfaceStatus
			obj_desk_selectedInterface_controller.controllerId = controllerId
			*/
			controllerId = obj_desk_buildInterface_controller.id
			cameraChange = true
		
			if buildInterfaceStatus == true{
				instance_destroy(obj_desk_buildInterface_figures)
				object_set_mask(obj_desk_buildInterface_figures,maskArr[cameraDistance+9])
				for(i = 0; i < 9; i++){
					figureId = instance_create_layer(x,y,"Interface",obj_desk_buildInterface_figures)
					figureId.type = i
					if type != -1 and i == type{
						figureId.selected = true
						figureId.dinamicY = dinamicY*cameraDistance
						figureId.status = "Up"
						controllerId.selectedId = figureId
					}
				}
			}
		
			cameraChange = false
		
		}
	}

}