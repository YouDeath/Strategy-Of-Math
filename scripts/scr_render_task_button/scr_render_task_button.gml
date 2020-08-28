task = argument0

instance_destroy(obj_work_button)

switch ds_map_find_value(task,"name"){
	case "Корни многочлена":{
		buttonId = instance_create_layer(obj_work_camera.x-statusDrawWidth*obj_work_camera.drawRelation+50,obj_work_camera.y+statusDrawHeight*obj_work_camera.drawRelation-70,"InterfaceUp",obj_work_button)
		buttonId.type = 1
		buttonId = instance_create_layer(obj_work_camera.x+statusDrawWidth*obj_work_camera.drawRelation-50,obj_work_camera.y+statusDrawHeight*obj_work_camera.drawRelation-70,"InterfaceUp",obj_work_button)
		buttonId.type = 0
		options = ds_map_find_value(task,"options")
		for (i = 0; i < 5; i++){
			for (j = 0; j < 2; j++){
				buttonId = instance_create_layer(obj_work_camera.x-(40-20*i)*obj_work_camera.drawRelation,obj_work_camera.y+20*obj_work_camera.drawRelation*j,"InterfaceUp",obj_work_button)
				buttonId.type = 2
				buttonId.number = options[i,j]				
			}
		}
		
		buttonId = instance_create_layer(obj_work_camera.x,obj_work_camera.y+40*obj_work_camera.drawRelation,"InterfaceUp",obj_work_button)
		buttonId.type = 2
		buttonId.number = "×"
		break
	}
}