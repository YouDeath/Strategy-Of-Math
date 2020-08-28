// Нажатие кнопки
if pressed == true{
	pressed = false
}
else{
	pressed = true
}

obj_lobby_client_controller.playerReady = pressed
obj_lobby_client_controller.updateStatus = true