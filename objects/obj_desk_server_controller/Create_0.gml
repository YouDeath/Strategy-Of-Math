// Инициализация параметров сервера
updatePlayerList = false
maxPlayer = 4
workGenerateSeed = current_time
part = "start"

// Инициализация массива готовности игроков

for(i = 0; i < maxPlayer; i++){
	isGenerate[i] = false
	/*
	colors[i,0] = irandom(256)
	colors[i,1] = irandom(256)
	colors[i,2] = irandom(256)
	*/
}

colors[0,0] = 255
colors[0,1] = 0
colors[0,2] = 0

colors[1,0] = 0
colors[1,1] = 255
colors[1,2] = 0

colors[2,0] = 0
colors[2,1] = 0
colors[2,2] = 255

colors[3,0] = 255
colors[3,1] = 0
colors[3,2] = 255

// Установка неизменяемости комнаты
room_set_persistent(mainLobby,false)