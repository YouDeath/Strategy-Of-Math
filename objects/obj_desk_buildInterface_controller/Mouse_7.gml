// Нажатие кнопки
if obj_desk_mouse_controller.idOfSelectedObject == id{
	press = false
	if buildInterfaceOpen == false{
		initialized = false
		drawBuyX = obj_desk_camera.x+(obj_desk_camera.sizeX/2+30)*obj_desk_camera.cameraDistance
		buildInterfaceOpen = true
		tick = 1
		object_set_mask(obj_desk_buildInterface_figures,maskArr[obj_desk_camera.cameraDistance])
		for(i = 0; i < 9; i++){
			figureId = instance_create_depth(x,y,i mod 2,obj_desk_buildInterface_figures)
			figureId.type = i
		}
	}
	else{
		price = 0
		drawPrice = false
		buildInterfaceOpen = false
		selectedId = 0
	}
}