// Инициализация параметров сервера
updatePlayerList = false
maxPlayer = 4

// Инициализация массива готовности игроков
for(i = 0; i < maxPlayer; i++){
	readyArr[i] = false
}

// Инициализация сервера
port = 25565;

global.server = network_create_server(network_socket_tcp, port, 32);
global.socketlist = ds_list_create()
