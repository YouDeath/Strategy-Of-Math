if owner == obj_desk_client_controller.myNum and obj_desk_turnInterface_controller.whoTurn == obj_desk_client_controller.myNum and selected == false and obj_desk_mouse_controller.idOfSelectedObject == id{
	
	scr_animationStatus_none()
	scr_figures_attack_status_none()
	
	if obj_desk_selectedInterface_controller.selectedSomeone == true{
		if instance_exists(obj_desk_selectedInterface_controller.selectedId){
			obj_desk_selectedInterface_controller.selectedId.selected = false
		}
		ds_map_set(obj_desk_map.figuresArr[obj_desk_selectedInterface_controller.selectedX,obj_desk_selectedInterface_controller.selectedY],"selected",false)
		obj_desk_selectedInterface_controller.selectedId = noone
		obj_desk_selectedInterface_controller.selectedSomeone = false
		if instance_exists(obj_desk_selectedInterface_controller.controllerId){
			instance_destroy(obj_desk_selectedInterface_controller.controllerId)
			instance_destroy(obj_desk_buildInterface_figures)
			obj_desk_selectedInterface_controller.controllerId = 0
		}
	} 
	
	selected = true
	ds_map_set(obj_desk_map.figuresArr[positionX,positionY],"selected",true)
	transparencyResult = scr_dinamic_change_transparency(1,"Down",0.04,0,1)
	obj_desk_selectedInterface_controller.selectedSomeone = true
	obj_desk_selectedInterface_controller.selectedId = id
	obj_desk_selectedInterface_controller.selectedX = positionX
	obj_desk_selectedInterface_controller.selectedY = positionY
	obj_desk_selectedInterface_controller.dinamicY = -150
	obj_desk_selectedInterface_controller.dinamicX = 0
	obj_desk_selectedInterface_controller.scaleFunctionParametrs = scr_create_scale_function([1,10,20],[-150,10,0])
	obj_desk_selectedInterface_controller.tick = 1
	obj_desk_selectedInterface_controller.selectedUpdate = true
}