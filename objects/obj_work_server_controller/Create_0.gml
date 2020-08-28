// Инициализация параметров сервера
updatePlayerList = false
maxPlayer = 4
workGenerateSeed = current_time
gotoDesk = false
allReady = false

// Инициализация массива готовности игроков
for(i = 0; i < maxPlayer; i++){
	readyArr[i] = false
}


/*
// Инициализация сервера
port = 6510;
global.server = network_create_server(network_socket_tcp, port, 32);
global.socketlist = ds_list_create()

while global.server < 0 and port < 65535{
   port++
   global.server = network_create_server(network_socket_tcp, port, 32);
}
*/

// Установка неизменяемости комнаты
room_set_persistent(mainLobby,false)