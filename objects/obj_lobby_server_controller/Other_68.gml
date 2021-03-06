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
		// Если тип пакета "Player Info Packet"
		case "Player Info Packet":{
			global.nameArr[networkId-2] = buffer_read(transitBuffer, buffer_string)
			show_debug_message("Connect "+string(networkId-2)+" name is "+global.nameArr[networkId-2])
			break;
		}
		
		// Если тип пакета "Ready State"
		case "Ready State":{
			readyArr[networkId-2] = buffer_read(transitBuffer, buffer_bool)
			if readyArr[networkId-2] == true{
				show_debug_message(global.nameArr[networkId-2]+" is ready!")
			}
			else{
				show_debug_message(global.nameArr[networkId-2]+" is not ready!")
			}
			break;
		}
		
		// Если тип пакета "Test Start"
		case "Test Start":{
			canStart = true
			
			// Если все игроки готовы, разрешает начать игру
			for (i = 0; i < ds_list_size(global.socketlist); i++){
				if readyArr[i] == false{
					canStart = false
					break;
				}
			}
				
			
			// Отправка информации о статусе игры клиентам
			transitBuffer = buffer_create(256, buffer_grow, 1)
			buffer_seek(transitBuffer, buffer_seek_start, 0)
			buffer_write(transitBuffer, buffer_string, "Start Info")
			buffer_write(transitBuffer, buffer_bool, canStart)

			for (i = 0; i < ds_list_size(global.socketlist); i++){
				network_send_packet(ds_list_find_value(global.socketlist, i), transitBuffer, buffer_tell(transitBuffer))
			}
				
			buffer_delete(transitBuffer)

			break;
		}
	}
}
