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
	
	obj_desk_client_controller.selectedColor = obj_desk_client_controller.playersColorArr[owner]
	
}

if inAttack == true{
	attackFigure = obj_desk_map.figuresArr[obj_desk_selectedInterface_controller.selectedX,obj_desk_selectedInterface_controller.selectedY]
	ds_map_set(attackFigure,"attackCan", false)
	scr_figures_attack_status_none()
	obj_desk_map.figuresArr[obj_desk_selectedInterface_controller.selectedX,obj_desk_selectedInterface_controller.selectedY] = attackFigure
	dmg = ds_map_find_value(attackFigure,"attackDMG")
	figure = obj_desk_map.figuresArr[positionX,positionY]
	hp = ds_map_find_value(figure,"hp")
	
	obj_desk_client_controller.fromX = obj_desk_selectedInterface_controller.selectedX
	obj_desk_client_controller.fromY = obj_desk_selectedInterface_controller.selectedY
	obj_desk_client_controller.toX = positionX
	obj_desk_client_controller.toY = positionY
	
	with obj_desk_client_controller{
		transitBuffer = buffer_create(256, buffer_grow, 1)
		buffer_seek(transitBuffer, buffer_seek_start, 0)
		buffer_write(transitBuffer, buffer_string, "Attack Figure")
		buffer_write(transitBuffer, buffer_s32, fromX)
		buffer_write(transitBuffer, buffer_s32, fromY)
		buffer_write(transitBuffer, buffer_s32, toX)
		buffer_write(transitBuffer, buffer_s32, toY)
		network_send_packet(global.client, transitBuffer, buffer_tell(transitBuffer))
		buffer_delete(transitBuffer)
	}
	
	if hp-dmg > 0{
		ds_map_set(figure,"hp",hp-dmg)
		obj_desk_map.figuresArr[positionX,positionY] = figure
	}
	else{
		
		obj_desk_map.figuresArr[positionX,positionY] = -1
		newAttackRadiusMin = ds_map_find_value(attackFigure,"attackRadiusMin")
		newAttackRadiusMax = ds_map_find_value(attackFigure,"attackRadiusMax")	
		
		scr_animationStatus_none()
		scr_figures_attack_status_none()	
		
		scr_linear_search_attack(obj_desk_selectedInterface_controller.selectedX,obj_desk_selectedInterface_controller.selectedY,newAttackRadiusMin,newAttackRadiusMax,"pressAttack")
		
		obj_desk_camera.needRender = true
		instance_destroy()
	}
}