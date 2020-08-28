// Инициализация параметров клиента
name = "Player1"
playerReady = false
updateStatus = false
testStart = false

// Инициализация подключения клиента
if global.playerStatus == "host"{
	global.client = network_create_socket(network_socket_tcp)
	server = network_connect(global.client,"localhost",obj_lobby_server_controller.port)
}
else{
	global.client = network_create_socket(network_socket_tcp)
	server = network_connect(global.client,global.serverIp,global.serverPort)
}


// Прередача данных клиента
transitBuffer = buffer_create(256, buffer_grow, 1)
buffer_seek(transitBuffer, buffer_seek_start, 0)
buffer_write(transitBuffer, buffer_string, "Player Info Packet")
buffer_write(transitBuffer, buffer_string, name)
network_send_packet(global.client, transitBuffer, buffer_tell(transitBuffer))
buffer_delete(transitBuffer)
