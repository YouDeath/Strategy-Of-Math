/*
if selectedUpdate == true{
	if ds_map_find_value(obj_desk_map.figuresArr[selectedX,selectedY],"type") == "base center"{
		controllerId = instance_create_layer(x,y,"Interface",obj_desk_buildInterface_controller)
		controllerId.dinamicY = -150
		controllerId.dinamicX = 0
		controllerId.scaleFunctionParametrs = scr_create_scale_function([1,10,20],[-150,10,0])
		controllerId.tick = 1
	}
	else{
		if instance_exists(controllerId){
			instance_destroy(controllerId)
			controllerId = 0
		}
	}
	selectedUpdate = false
}
*/

if selectedUpdate == true{
	if instance_exists(controllerId){
		instance_destroy(controllerId)
		controllerId = 0
	}
		
	for (i = 0; i < 5; i++){
		instance_destroy(obj_desk_selectedInterface_info)
		if instance_exists(abilitiesIdArr[i]){
			instance_destroy(abilitiesIdArr[i])
		}
	}
	
	if is_real(ds_map_find_value(obj_desk_map.figuresArr[selectedX,selectedY],"type")){
		infoId = instance_create_layer(x,y,"Interface",obj_desk_selectedInterface_info)
		for (i = 0; i < 5; i++){
			abilitiesId = instance_create_layer(x,y,"Interface",obj_desk_selecedInterface_abilities)
			abilitiesId.type = i
			abilitiesIdArr[i] = abilitiesId
		}
	}
	else{
		switch ds_map_find_value(obj_desk_map.figuresArr[selectedX,selectedY],"type"){
			case "base center":{
				show_debug_message("interface")
				controllerId = instance_create_layer(x,y,"Interface",obj_desk_buildInterface_controller)
				controllerId.dinamicY = -150
				controllerId.dinamicX = 0
				controllerId.scaleFunctionParametrs = scr_create_scale_function([1,10,20],[-150,10,0])
				controllerId.tick = 1
				break
			}
		}
	}
	selectedUpdate = false
}