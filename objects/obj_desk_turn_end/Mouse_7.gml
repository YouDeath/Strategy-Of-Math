// Нажатие кнопки
if obj_desk_mouse_controller.idOfSelectedObject == id{
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
		
		if instance_exists(obj_desk_selecedInterface_abilities){
			instance_destroy(obj_desk_selecedInterface_abilities)	
		}
	}

	with obj_desk_client_controller{
		transitBuffer = buffer_create(256, buffer_grow, 1)
		buffer_seek(transitBuffer, buffer_seek_start, 0)
		buffer_write(transitBuffer, buffer_string, "Turn End")
		buffer_write(transitBuffer, buffer_s8, myNum)
		network_send_packet(global.client, transitBuffer, buffer_tell(transitBuffer))
		buffer_delete(transitBuffer)
	}
	
	obj_desk_client_controller.money+=obj_desk_client_controller.moneyAddTurn

	scr_animationStatus_none()
	scr_figures_attack_status_none()

	instance_destroy()
}

for (i = 0; i < ds_map_find_value(global.settingsGame,"mapSizeX"); i++){
	for (j = 0; j < ds_map_find_value(global.settingsGame,"mapSizeY"); j++){
		if obj_desk_map.figuresArr[i,j] != -1{
			figure = obj_desk_map.figuresArr[i,j]
			if ds_map_find_value(figure,"player") == obj_desk_client_controller.myNum{
				ds_map_set(figure,"stepCan",true)
				ds_map_set(figure,"attackCan",true)
				obj_desk_map.figuresArr[i,j] = figure
			}
		}		
	}
}