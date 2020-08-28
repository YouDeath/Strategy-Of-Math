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
			show_debug_message(workGenerateSeed)
			obj_task_manager.generateSeed = workGenerateSeed
			with obj_task_manager{
				random_set_seed(generateSeed)
				task = scr_generate_task()
				scr_render_task_button(task)
				selecting[0] = noone
				selecting[1] = noone
			}
			break
		}
		
		case "All Ready":{
			room_goto(multiDesk)
			break
		}
	}
	
}
