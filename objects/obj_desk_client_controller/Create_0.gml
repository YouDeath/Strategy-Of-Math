// Инициализация параметров клиента
name = "Player1"
playerReady = false
updateStatus = false
testStart = false
mapGenerated = false
myTurn = false
menuOpen = false
ask = false
money = 1000
moneyAddTurn = 200


/*
// Инициализация подключения клиента
global.client = network_create_socket(network_socket_tcp)
server = network_connect(global.client,"192.168.1.101",obj_lobby_server_controller.port)
*/

// Прередача данных клиента

transitBuffer = buffer_create(256, buffer_grow, 1)
buffer_seek(transitBuffer, buffer_seek_start, 0)
buffer_write(transitBuffer, buffer_string, "Request For Settings")
network_send_packet(global.client, transitBuffer, buffer_tell(transitBuffer))
buffer_delete(transitBuffer)


transitBuffer = buffer_create(256, buffer_grow, 1)
buffer_seek(transitBuffer, buffer_seek_start, 0)
buffer_write(transitBuffer, buffer_string, "Request For Seed")
network_send_packet(global.client, transitBuffer, buffer_tell(transitBuffer))
buffer_delete(transitBuffer)
