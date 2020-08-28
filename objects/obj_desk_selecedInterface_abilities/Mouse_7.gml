if canPress == true{
	press = false

	figureId = obj_desk_selectedInterface_controller.selectedId
	positionX = obj_desk_selectedInterface_controller.selectedX
	positionY = obj_desk_selectedInterface_controller.selectedY
	figure = obj_desk_map.figuresArr[positionX,positionY]

	switch type{
		case 0:{
			scr_animationStatus_none()
			scr_figures_attack_status_none()
			hpMax = ds_map_find_value(figure,"hpMax")
			hp = ds_map_find_value(figure,"hp")
		
			if hp+1 <= hpMax{
				ds_map_set(figure,"hp",hp+1)
				obj_desk_map.figuresArr[positionX,positionY] = figure
			}
	
			break
		}
		case 1:{
			scr_animationStatus_none()
			scr_figures_attack_status_none()
			show_debug_message(ds_map_find_value(figure,"type"))
			steps = ds_map_find_value(figure,"step")
			scr_linear_search_step(positionX,positionY,steps,"pressStep")
			break 
		}
		case 2:{
			scr_animationStatus_none()
			scr_figures_attack_status_none()
		
			attackRadiusMin = ds_map_find_value(figure,"attackRadiusMin")
			attackRadiusMax = ds_map_find_value(figure,"attackRadiusMax")
			attackDMG = ds_map_find_value(figure,"attackDMG")
		
			scr_linear_search_attack(positionX,positionY,attackRadiusMin,attackRadiusMax,"pressAttack")
			break
		}
	}
}