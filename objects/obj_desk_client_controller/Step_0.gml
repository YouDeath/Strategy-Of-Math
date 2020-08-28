// Передача пакета на сервер

// Передача оповещение о готовности генерации карты
if mapGenerated == true{
	
	transitBuffer = buffer_create(256, buffer_grow, 1)
	buffer_seek(transitBuffer, buffer_seek_start, 0)
	buffer_write(transitBuffer, buffer_string, "Map Is Generated")
	network_send_packet(global.client, transitBuffer, buffer_tell(transitBuffer))
	buffer_delete(transitBuffer)
	
	mapGenerated = false
}