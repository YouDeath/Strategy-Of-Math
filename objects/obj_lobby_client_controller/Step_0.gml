// Передача пакета на сервер

// Передача значения готовности клиента на сервер
if updateStatus == true{
	
	transitBuffer = buffer_create(256, buffer_grow, 1)
	buffer_seek(transitBuffer, buffer_seek_start, 0)
	buffer_write(transitBuffer, buffer_string, "Ready State")
	buffer_write(transitBuffer, buffer_bool, playerReady)
	network_send_packet(global.client, transitBuffer, buffer_tell(transitBuffer))
	buffer_delete(transitBuffer)
	
	updateStatus = false
}

// Передача желания хоста начать игру
if testStart == true{
	
	transitBuffer = buffer_create(256, buffer_grow, 1)
	buffer_seek(transitBuffer, buffer_seek_start, 0)
	buffer_write(transitBuffer, buffer_string, "Test Start")
	network_send_packet(global.client, transitBuffer, buffer_tell(transitBuffer))
	buffer_delete(transitBuffer)
	
	testStart = false
}