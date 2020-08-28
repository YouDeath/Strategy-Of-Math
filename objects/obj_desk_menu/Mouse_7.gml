// Нажатие кнопки
if obj_desk_mouse_controller.idOfSelectedObject == id{
	obj_desk_client_controller.menuOpen = true
	visible = false
	instance_create_depth(obj_desk_camera.x,obj_desk_camera.y,-1,obj_desk_menu_controller)
}