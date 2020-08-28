press = false
if obj_task_manager.animationStatus = "noone"{
	if type == 0 {
		with obj_task_manager{
			total = string(selecting[0])+";"+string(selecting[1])
			if total == ds_map_find_value(task,"answer1") or total == ds_map_find_value(task,"answer2"){
				obj_work_draw_interface.taskStatuses[taskNow] = "correct"
				animationStatus = "correct"
			}
			else{
				obj_work_draw_interface.taskStatuses[taskNow] = "uncorrect"
				animationStatus = "uncorrect"
			}
			transparencyResult = scr_dinamic_change_transparency(0,"Up",0.05,0,1)
			canBack = false
		}
	}

	if type == 1{
		with obj_task_manager{
			obj_work_draw_interface.taskStatuses[taskNow] = "uncorrect"
			animationStatus = "uncorrect"
			transparencyResult = scr_dinamic_change_transparency(0,"Up",0.05,0,1)
			canBack = false
		}
	}

	if type == 2{
		if number == "×"{
			if obj_task_manager.selecting[1] != noone{
				obj_task_manager.selecting[1] = noone
			}
			else{
				obj_task_manager.selecting[0] = noone
			}
		}
		else{
			if obj_task_manager.selecting[0] == noone{
				obj_task_manager.selecting[0] = number
			}
			else{
				if obj_task_manager.selecting[1] == noone{
					obj_task_manager.selecting[1] = number
				}
			}
		}
	}
}