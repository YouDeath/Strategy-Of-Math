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
		
		// Если тип пакета "Start Info"
		case "Start Info":{
			startStatus = buffer_read(transitBuffer, buffer_bool)
			if startStatus == true{
				show_debug_message("The game is ready to launch")
				room_goto(multiWork)
			}
			else{
				show_debug_message("The game is not ready to launch")
			}
			break;
		}
	}
	
}