// Получение id вызвавшего ивент
networkId = ds_map_find_value(async_load, "id")

// Если ивент вызвал сервер
if networkId == global.client{
	
	// Получение пакета
	transitBuffer = ds_map_find_value(async_load, "buffer")
	
	// Получение информации о пакете
	cmdType = buffer_read(transitBuffer, buffer_string);
	
	// Распределитель обработчиков пакетов
	switch cmdType{	
		
		// Если тип пакета "Generate Seed"
		case "Generate Seed":{
			workGenerateSeed = buffer_read(transitBuffer, buffer_u16)
			instance_create_layer(x,y,"Service",obj_desk_map)
			show_debug_message("seed is getting")
			break
		}
		
		// Если тип пакета "All Have Generated"
		case "All Have Generated":{
			instance_create_layer(x,y,"Service",obj_desk_camera)
			obj_desk_camera.rendering = true
			break
		}
		
		// Если тип пакета "Game Settings"
		case "Game Settings":{
			
			global.settingsGame = ds_map_create()
			
			ds_map_add(global.settingsGame,"mapSizeX", buffer_read(transitBuffer, buffer_s16))
			ds_map_add(global.settingsGame,"mapSizeY", buffer_read(transitBuffer, buffer_s16))
			ds_map_add(global.settingsGame,"generateChanceAqua", buffer_read(transitBuffer, buffer_f16))
			ds_map_add(global.settingsGame,"generateChanceGrass", buffer_read(transitBuffer, buffer_f16))
			ds_map_add(global.settingsGame,"generateChanceMount", buffer_read(transitBuffer, buffer_f16))
			ds_map_add(global.settingsGame,"smoothingHowIteration", buffer_read(transitBuffer, buffer_f16))
			ds_map_add(global.settingsGame,"generateChanceForest", buffer_read(transitBuffer, buffer_f16))
			ds_map_add(global.settingsGame,"generateChanceForestMore", buffer_read(transitBuffer, buffer_f16))
			ds_map_add(global.settingsGame,"generateChanceRange", buffer_read(transitBuffer, buffer_f16))
			ds_map_add(global.settingsGame,"generateChanceRangeMore", buffer_read(transitBuffer, buffer_f16))
			ds_map_add(global.settingsGame,"generateHowPlayers", buffer_read(transitBuffer, buffer_s8))
			ds_map_add(global.settingsGame,"fogOfWar", buffer_read(transitBuffer, buffer_bool))		
			break
		}

		// Если тип пакета "Number In Game"
		case "Number In Game":{
			show_debug_message("number in game")
			myNum = buffer_read(transitBuffer, buffer_s8)
			baseX = obj_desk_map.generateBasesPosition[myNum,0]+2
			baseY = obj_desk_map.generateBasesPosition[myNum,1]+2
			for(i = -5; i < 6; i++){
				for(j = -5; j < 6; j++){
					if abs(i)+abs(j) < 6 and scr_arguments_in_arrsize(obj_desk_map.MapInfoArr,i+baseX,j+baseY) == true{
						cell = obj_desk_map.cellsArr[baseX+i,baseY+j]
						ds_map_set(cell,"create",true)
						obj_desk_map.cellsArr[baseX+i,baseY+j] = cell
					}
				}
			}
			
			// Создание базы
			
			create_par = 4
			baseCreateX = (36+create_par)*(baseX-baseY)
			baseCreateY = baseX*(36+create_par)+baseY*(36+create_par)	
			
			for(i = 0; i < ds_map_find_value(global.settingsGame,"generateHowPlayers"); i++){
				if i == myNum{
					for(ini = 1; ini < 4; ini++){
						for(inj = 1; inj < 4; inj++){
							if ini == 2 and inj == 2{
								figure = ds_map_create()
								ds_map_add(figure,"type","base center")
								ds_map_add(figure,"player",myNum)
								ds_map_add(figure,"fogOpen",5)
									
								baseId = instance_create_layer(baseCreateX,baseCreateY,"IngameFigures",obj_desk_town)
								show_debug_message("baseId = "+string(baseId))
								
								interfaceId = instance_create_layer(0,0,"Interface",obj_desk_turnInterface_controller)
								interfaceId.playersColorArr = playersColorArr
								baseId.color = playersColorArr[myNum]
								baseId.owner = myNum
								baseId.positionX = obj_desk_map.generateBasesPosition[myNum,0]+ini
								baseId.positionY = obj_desk_map.generateBasesPosition[myNum,1]+inj
								ds_map_add(figure,"id",baseId)
								ds_map_add(figure,"selected",false)
								ds_map_add(figure,"inAttack",false)
								show_debug_message(obj_desk_map.generateBasesPosition[myNum,0])
								show_debug_message(obj_desk_map.generateBasesPosition[myNum,1])
								obj_desk_map.figuresArr[obj_desk_map.generateBasesPosition[myNum,0]+ini,obj_desk_map.generateBasesPosition[myNum,1]+inj] = figure
							}
							else{
								figure = ds_map_create()
								ds_map_add(figure,"type","base additional")
								ds_map_add(figure,"fogOpen",5)
								ds_map_add(figure,"player",myNum)
								ds_map_add(figure,"selected",false)
								ds_map_add(figure,"id",noone)
								ds_map_add(figure,"inAttack",false)
								obj_desk_map.figuresArr[obj_desk_map.generateBasesPosition[myNum,0]+ini,obj_desk_map.generateBasesPosition[myNum,1]+inj] = figure
							}
						}
					}
				}
				else{
					for(ini = 1; ini < 4; ini++){
						for(inj = 1; inj < 4; inj++){
							if ini == 2 and inj == 2{
								figure = ds_map_create()
								ds_map_add(figure,"type","base center")
								ds_map_add(figure,"player",i)
								ds_map_add(figure,"selected",false)
								ds_map_add(figure,"id",noone)
								obj_desk_map.figuresArr[obj_desk_map.generateBasesPosition[i,0]+ini,obj_desk_map.generateBasesPosition[i,1]+inj] = figure
							}
							else{
								figure = ds_map_create()
								ds_map_add(figure,"type","base additional")
								ds_map_add(figure,"player",i)
								ds_map_add(figure,"selected",false)
								obj_desk_map.figuresArr[obj_desk_map.generateBasesPosition[i,0]+ini,obj_desk_map.generateBasesPosition[i,1]+inj] = figure
							}
						}
					}
				}
			}
		
			scr_fog_render_all(obj_desk_map.generateBasesPosition[myNum,0],obj_desk_map.generateBasesPosition[myNum,1])
		
			obj_desk_camera.needRender = true
			obj_desk_camera.x = baseCreateX
			obj_desk_camera.y = baseCreateY
			with obj_desk_camera{
					vm = matrix_build_lookat(x, y, -1000, x, y, 0, 0, 1, 0)
					camera_set_view_mat(camera, vm)
			}
			
			if myNum == 0{
				createX = obj_desk_camera.x-obj_desk_camera.sizeX*obj_desk_camera.cameraDistance/2+384*obj_desk_camera.cameraDistance
				createY = obj_desk_camera.y-obj_desk_camera.sizeY*obj_desk_camera.cameraDistance/2+32*obj_desk_camera.cameraDistance
				instance_create_layer(createX,createY,"Interface",obj_desk_turn_end)
			}
			break
		}
		
		// Если тип пакета "Players Colours"
		case "Players Colours":{
			show_debug_message("Color Get")
			how = buffer_read(transitBuffer, buffer_s8)
			
			for(i = 0; i < how; i++){
				red = buffer_read(transitBuffer, buffer_s16)
				green = buffer_read(transitBuffer, buffer_s16)
				blue = buffer_read(transitBuffer, buffer_s16)
				playersColorArr[i] = make_color_rgb(red,green,blue)
			}
			
			break
		}
		
		// Если тип пакета "Who Turn Update"
		case "Who Turn Update":{
			show_debug_message("New Turn")
			
			obj_desk_turnInterface_controller.whoTurn = buffer_read(transitBuffer, buffer_s8)
			obj_desk_turnInterface_controller.newTurn = true
			obj_desk_turnInterface_controller.tick = 1
			obj_desk_turnInterface_controller.drawStartX = -obj_desk_camera.sizeX/2
			obj_desk_turnInterface_controller.drawEndX = -obj_desk_camera.sizeX/2
			if obj_desk_turnInterface_controller.whoTurn == myNum{
				createX = obj_desk_camera.x-obj_desk_camera.sizeX*obj_desk_camera.cameraDistance/2+384*obj_desk_camera.cameraDistance
				createY = obj_desk_camera.y-obj_desk_camera.sizeY*obj_desk_camera.cameraDistance/2+32*obj_desk_camera.cameraDistance
				instance_create_layer(createX,createY,"Interface",obj_desk_turn_end)
			}
			
			break
		}
		
		case "New Figure":{
			show_debug_message("new Figure")
			positionX = buffer_read(transitBuffer, buffer_s16)
			positionY = buffer_read(transitBuffer, buffer_s16)
			type = buffer_read(transitBuffer, buffer_s16)
			player = buffer_read(transitBuffer, buffer_s16)
			
			figure = ds_map_create()
			ds_map_add(figure,"type",real(type))
			ds_map_add(figure,"player",real(player))
			ds_map_add(figure,"selected",false)
			
			setupFigures = obj_desk_figures_settings.setupFigures[real(type)]
			
			hp = ds_map_find_value(setupFigures,"maxHp")
			
			ds_map_add(figure,"maxhp",hp)
			ds_map_add(figure,"hp",hp)
			
			step = ds_map_find_value(setupFigures,"stepLenght")
			
			ds_map_add(figure,"step",step)
			
			attackRadiusMin = ds_map_find_value(setupFigures,"attackStart")
			attackRadiusMax = ds_map_find_value(setupFigures,"attackEnd")
			attackDMG = ds_map_find_value(setupFigures,"dmg")
			
			ds_map_add(figure,"attackRadiusMin",attackRadiusMin)
			ds_map_add(figure,"attackRadiusMax",attackRadiusMax)
			ds_map_add(figure,"attackDMG",attackDMG)
			
			obj_desk_map.figuresArr[positionX,positionY] = figure
			obj_desk_camera.needRender = true
			
			break
		}
		
		case "Move Figure":{
			
			fromX = buffer_read(transitBuffer, buffer_s32)
			fromY = buffer_read(transitBuffer, buffer_s32)
			toX = buffer_read(transitBuffer, buffer_s32)
			toY = buffer_read(transitBuffer, buffer_s32)
			
			figure = obj_desk_map.figuresArr[fromX,fromY]
			obj_desk_map.figuresArr[toX,toY] = figure
			obj_desk_map.figuresArr[fromX,fromY] = -1
			obj_desk_camera.needRender = true
			
			break
		}
		
		case "Attack Figure":{
			fromX = buffer_read(transitBuffer, buffer_s32)
			fromY = buffer_read(transitBuffer, buffer_s32)
			toX = buffer_read(transitBuffer, buffer_s32)
			toY = buffer_read(transitBuffer, buffer_s32)
			
			attackFigure = obj_desk_map.figuresArr[fromX,fromY]
			dmg = ds_map_find_value(attackFigure,"attackDMG")
			figure = obj_desk_map.figuresArr[toX,toY]
			hp = ds_map_find_value(figure,"hp")
			
			if hp-dmg > 0{
				ds_map_set(figure,"hp",hp-dmg)
				obj_desk_map.figuresArr[toX,toY] = figure
			}
			else{
				figureId = ds_map_find_value(figure,"id")
				obj_desk_map.figuresArr[toX,toY] = -1
				obj_desk_camera.needRender = true
				if instance_exists(figureId){
					instance_destroy(figureId)
				}
			}
			
			break
		}
		
	}
	
}
