// Зануление
clientData = false

// Получения id
networkId = ds_map_find_value(async_load,"id")

// Если пакет от сервера
if networkId == global.server{
	
	// Получение типа соединения
	connectType = ds_map_find_value(async_load, "type")
	switch connectType{
		// Если ивент вызван подключением
		case network_type_connect:{
			connectSocket = ds_map_find_value(async_load, "socket")
			ds_list_add(global.socketlist, connectSocket)
			show_debug_message("Conected")
			show_debug_message(ds_list_find_value(global.socketlist,0))
			break
		}
		
		// Если ивент вызван отключением
		case network_type_disconnect:{
			connectSocket = ds_map_find_value(async_load, "socket")
			ds_list_delete(global.socketlist, connectSocket)
			show_debug_message("Disconected")
			show_debug_message(global.socketlist)
			break
		}
		
		// Если ивент передачей информации
		case network_type_data:{
			
		}
		
	}
	
}
else{
	// Если пакет не от сервера, то определяем от какого клента пришёл пакет
	for(i = 0; i < ds_list_size(global.socketlist); i++){
		if networkId == ds_list_find_value(global.socketlist,i){
			clientData = true
			break
		}
	}
}

// Если обнаружен клиент от которого пришёл пакет, то обрабатываем его
if clientData == true{
	
	// Получение пакета
	transitBuffer = ds_map_find_value(async_load, "buffer")
	
	// Получение информации о пакете
	cmdType = buffer_read(transitBuffer, buffer_string);
	
	// Распределитель обработчиков пакетов
	switch cmdType{	
		
		// Если тип пакета "Request For Settings"
		case "Request For Settings":{	
			
			// Отправка сида для генерации карты игрокам
			transitBuffer = buffer_create(256, buffer_grow, 1)
			buffer_seek(transitBuffer, buffer_seek_start, 0)
			buffer_write(transitBuffer, buffer_string, "Game Settings")
			
			buffer_write(transitBuffer, buffer_s16, 64) // mapSizeX
			buffer_write(transitBuffer, buffer_s16, 64) // mapSizeY
			buffer_write(transitBuffer, buffer_f16, 0.33) // generateChanceAqua
			buffer_write(transitBuffer, buffer_f16, 0.33) // generateChanceGrass
			buffer_write(transitBuffer, buffer_f16, 0.34) // generateChanceMount
			buffer_write(transitBuffer, buffer_f16, 20) // smoothingHowIteration
			buffer_write(transitBuffer, buffer_f16, 0.05) // generateChanceForest
			buffer_write(transitBuffer, buffer_f16, 0.3) // generateChanceForestMore
			buffer_write(transitBuffer, buffer_f16, 0.3) // generateChanceRange
			buffer_write(transitBuffer, buffer_f16, 0.8) // generateChanceRangeMore
			buffer_write(transitBuffer, buffer_s8, ds_list_size(global.socketlist)) // generateHowPlayers
			buffer_write(transitBuffer, buffer_bool, false) // fogOfWar

			network_send_packet(networkId, transitBuffer, buffer_tell(transitBuffer))
				
			buffer_delete(transitBuffer)
			
			break;
		}
		
		// Если тип пакета "Request For Seed"
		case "Request For Seed":{	
			
			// Отправка сида для генерации карты игрокам
			transitBuffer = buffer_create(256, buffer_grow, 1)
			buffer_seek(transitBuffer, buffer_seek_start, 0)
			buffer_write(transitBuffer, buffer_string, "Generate Seed")
			buffer_write(transitBuffer, buffer_u16, workGenerateSeed)

			network_send_packet(networkId, transitBuffer, buffer_tell(transitBuffer))
				
			buffer_delete(transitBuffer)
			
			break;
		}
		
		// Если тип пакета "Map Is Generated"
		case "Map Is Generated":{		
			
			// Отправка приём информации о готовности генерации у игрока
			isGenerate[networkId-2] = true
			
			if isGenerate[networkId-2] == true{
				show_debug_message(global.nameArr[networkId-2]+" have generated Map!")
			}
			
			allGenerate = true
			
			for(i = 0; i < ds_list_size(global.socketlist); i++){
				if isGenerate[i] = false{
					allGenerate = false
					break;
				}
			}
			
			if allGenerate == true{
				
				// Отправка разрешения начала игры
				show_debug_message("Game Started")
				transitBuffer = buffer_create(256, buffer_grow, 1)
				buffer_seek(transitBuffer, buffer_seek_start, 0)
				buffer_write(transitBuffer, buffer_string, "All Have Generated")

				for (i = 0; i < ds_list_size(global.socketlist); i++){
					network_send_packet(ds_list_find_value(global.socketlist, i), transitBuffer, buffer_tell(transitBuffer))
				}
				
				buffer_delete(transitBuffer)
			
			}
			
			break;
		}
		
				// Если тип пакета "Map Is Generated"
		case "Turn End":{		
			
			whoEndTurn = buffer_read(transitBuffer, buffer_s8)
			howPlayers = ds_list_size(global.socketlist)
			
			whoEndTurn++
			whoEndTurn = whoEndTurn mod howPlayers
			
			// Отправка нового ходящего
			transitBuffer = buffer_create(256, buffer_grow, 1)
			buffer_seek(transitBuffer, buffer_seek_start, 0)
			buffer_write(transitBuffer, buffer_string, "Who Turn Update")
			buffer_write(transitBuffer, buffer_s8, whoEndTurn)

			for (i = 0; i < ds_list_size(global.socketlist); i++){
				network_send_packet(ds_list_find_value(global.socketlist, i), transitBuffer, buffer_tell(transitBuffer))
			}
				
			buffer_delete(transitBuffer)

			
			break;
		}
		
		case "New Figure":{
			positionX = buffer_read(transitBuffer, buffer_s16)
			positionY = buffer_read(transitBuffer, buffer_s16)
			type = buffer_read(transitBuffer, buffer_s16)
			player = buffer_read(transitBuffer, buffer_s16)
			
			transitBuffer = buffer_create(256, buffer_grow, 1)
			buffer_seek(transitBuffer, buffer_seek_start, 0)
			buffer_write(transitBuffer, buffer_string, "New Figure")
			buffer_write(transitBuffer, buffer_s16, positionX)
			buffer_write(transitBuffer, buffer_s16, positionY)
			buffer_write(transitBuffer, buffer_s16, type)
			buffer_write(transitBuffer, buffer_s16, player)
			
			for (i = 0; i < ds_list_size(global.socketlist); i++){
				if i != networkId-2{
					network_send_packet(ds_list_find_value(global.socketlist, i), transitBuffer, buffer_tell(transitBuffer))
				}
			}
			
			buffer_delete(transitBuffer)	
			
			break;
		}
		
		case "Move Figure":{
			
			fromX = buffer_read(transitBuffer, buffer_s32)
			fromY = buffer_read(transitBuffer, buffer_s32)
			toX = buffer_read(transitBuffer, buffer_s32)
			toY = buffer_read(transitBuffer, buffer_s32)
			
			transitBuffer = buffer_create(256, buffer_grow, 1)
			buffer_seek(transitBuffer, buffer_seek_start, 0)
			buffer_write(transitBuffer, buffer_string, "Move Figure")
			buffer_write(transitBuffer, buffer_s32, fromX)
			buffer_write(transitBuffer, buffer_s32, fromY)
			buffer_write(transitBuffer, buffer_s32, toX)
			buffer_write(transitBuffer, buffer_s32, toY)
			
			for (i = 0; i < ds_list_size(global.socketlist); i++){
				if i != networkId-2{
					network_send_packet(ds_list_find_value(global.socketlist, i), transitBuffer, buffer_tell(transitBuffer))
				}
			}
			
			break
		}
		
		case "Attack Figure":{
			fromX = buffer_read(transitBuffer, buffer_s32)
			fromY = buffer_read(transitBuffer, buffer_s32)
			toX = buffer_read(transitBuffer, buffer_s32)
			toY = buffer_read(transitBuffer, buffer_s32)
			
			transitBuffer = buffer_create(256, buffer_grow, 1)
			buffer_seek(transitBuffer, buffer_seek_start, 0)
			buffer_write(transitBuffer, buffer_string, "Attack Figure")
			buffer_write(transitBuffer, buffer_s32, fromX)
			buffer_write(transitBuffer, buffer_s32, fromY)
			buffer_write(transitBuffer, buffer_s32, toX)
			buffer_write(transitBuffer, buffer_s32, toY)
			
			for (i = 0; i < ds_list_size(global.socketlist); i++){
				if i != networkId-2{
					network_send_packet(ds_list_find_value(global.socketlist, i), transitBuffer, buffer_tell(transitBuffer))
				}
			}
			
			break
		}
	}
}
