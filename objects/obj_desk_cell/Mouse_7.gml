if obj_desk_client_controller.menuOpen == false{
	if empty == true and obj_desk_mouse_controller.idOfSelectedObject == id and ds_map_find_value(cell,"create") == true and type > 1{
		if instance_exists(obj_desk_buildInterface_controller) == true{
			if obj_desk_buildInterface_controller.selectedId != 0{
				empty = false
				createType = obj_desk_buildInterface_controller.selectedId.type
				
				setupFigures = obj_desk_figures_settings.setupFigures[createType]
				
				price = ds_map_find_value(setupFigures,"price")
				
				if obj_desk_client_controller.money - price >= 0{
					
					obj_desk_client_controller.money-=price
					
					figure = ds_map_create()
					ds_map_add(figure,"type",createType)
					ds_map_add(figure,"player",obj_desk_client_controller.myNum)
					ds_map_add(figure,"selected",false)
					
					fogOpen = ds_map_find_value(setupFigures,"fogOpen")
					
					ds_map_add(figure,"fogOpen",fogOpen)
					
					hp = ds_map_find_value(setupFigures,"maxHp")
			
					ds_map_add(figure,"hpMax",hp)
					ds_map_add(figure,"hp",hp)
			
					step = ds_map_find_value(setupFigures,"stepLenght")
			
					ds_map_add(figure,"step",step)
					ds_map_add(figure,"stepCan",true)
			
					attackRadiusMin = ds_map_find_value(setupFigures,"attackStart")
					attackRadiusMax = ds_map_find_value(setupFigures,"attackEnd")
					attackDMG = ds_map_find_value(setupFigures,"dmg")
			
					ds_map_add(figure,"attackRadiusMin",attackRadiusMin)
					ds_map_add(figure,"attackRadiusMax",attackRadiusMax)
					ds_map_add(figure,"attackDMG",attackDMG)
					ds_map_add(figure,"attackCan",true)
			
					ds_map_add(figure,"inAttack",false)
					ds_map_add(figure,"id",noone)
			
					obj_desk_map.figuresArr[positionX,positionY] = figure
			
					figure = obj_desk_map.figuresArr[positionX,positionY]
					figureType = ds_map_find_value(figure,"type")
					if is_real(type){
						figureId = instance_create_layer(x,y,"IngameFigures",obj_desk_figure)
						figureId.owner = ds_map_find_value(figure,"player")
						figureId.type = figureType
						figureId.positionX = positionX 
						figureId.positionY = positionY
						figureId.depth = layer_get_depth(layer_get_id("IngameCells"))-positionX-positionY
						figureId.draw_x = obj_desk_buildInterface_controller.selectedId.x
						figureId.draw_y = obj_desk_buildInterface_controller.selectedId.y
						figureId.initialized = false
						ds_map_set(figure,"id",figureId)
						scr_fog_set_open(positionX,positionY)
				
						obj_desk_client_controller.positionX = positionX
						obj_desk_client_controller.positionY = positionY
						obj_desk_client_controller.type = figureType
						obj_desk_camera.needRender = true
				
						with obj_desk_client_controller{
								transitBuffer = buffer_create(256, buffer_grow, 1)
								buffer_seek(transitBuffer, buffer_seek_start, 0)
								buffer_write(transitBuffer, buffer_string, "New Figure")
								buffer_write(transitBuffer, buffer_s16, positionX)
								buffer_write(transitBuffer, buffer_s16, positionY)
								buffer_write(transitBuffer, buffer_s16, type)
								buffer_write(transitBuffer, buffer_s16, myNum)
								network_send_packet(global.client, transitBuffer, buffer_tell(transitBuffer))
								buffer_delete(transitBuffer)
						}
				
					}
					else{
						switch figureType{
							case "base center":{
			
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

	if animationStatus == "pressStep"{
		fromX = obj_desk_selectedInterface_controller.selectedX
		fromY = obj_desk_selectedInterface_controller.selectedY
		
		if ds_map_find_value(global.settingsGame,"fogOfWar") == true{
			scr_fog_set_wasOpen(fromX,fromY)
		} 
		

		fromX = obj_desk_selectedInterface_controller.selectedX
		fromY = obj_desk_selectedInterface_controller.selectedY
		
		figure = obj_desk_map.figuresArr[fromX,fromY]
		
		obj_desk_map.figuresArr[fromX,fromY] = -1
		obj_desk_selectedInterface_controller.selectedX = positionX
		obj_desk_selectedInterface_controller.selectedY = positionY
		ds_map_set(figure,"stepCan", false)
		obj_desk_map.figuresArr[positionX,positionY] = figure
		obj_desk_camera.needRender = true
		if ds_map_find_value(global.settingsGame,"fogOfWar") == true{
			scr_fog_render_all(fromX,fromY)
			scr_fog_set_open(positionX,positionY)
		}
		scr_animationStatus_none()
		obj_desk_client_controller.fromX = fromX
		obj_desk_client_controller.fromY = fromY
		obj_desk_client_controller.toX = positionX
		obj_desk_client_controller.toY = positionY
	
	
		with obj_desk_client_controller{
			transitBuffer = buffer_create(256, buffer_grow, 1)
			buffer_seek(transitBuffer, buffer_seek_start, 0)
			buffer_write(transitBuffer, buffer_string, "Move Figure")
			buffer_write(transitBuffer, buffer_s32, fromX)
			buffer_write(transitBuffer, buffer_s32, fromY)
			buffer_write(transitBuffer, buffer_s32, toX)
			buffer_write(transitBuffer, buffer_s32, toY)
			network_send_packet(global.client, transitBuffer, buffer_tell(transitBuffer))
			buffer_delete(transitBuffer)
		}
	
	}
}
