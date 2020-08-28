scr_draw_rectangle_style(statusDrawWidth,statusDrawHeight,statusLeft,statusUp,c_my_gray,c_my_gray_dark)

draw_line_width_color(obj_work_camera.x-statusDrawWidth*obj_work_camera.drawRelation,obj_work_camera.y-7*statusDrawHeight/8*obj_work_camera.drawRelation,obj_work_camera.x+statusDrawWidth*obj_work_camera.drawRelation,obj_work_camera.y-7*statusDrawHeight/8*obj_work_camera.drawRelation,obj_work_camera.drawRelation,c_my_gray_dark,c_my_gray_dark)

if ds_map_find_value(task,"name") == "Корни многочлена"{
	name = ds_map_find_value(task,"name")
	draw_set_font(font_main)
	draw_text_color(obj_work_camera.x-35*obj_work_camera.drawRelation,obj_work_camera.y-(statusDrawHeight+4)*obj_work_camera.drawRelation,name,c_my_gray_dark,c_my_gray_dark,c_my_gray_dark,c_my_gray_dark,1)

	function = ds_map_find_value(task,"function")

	statusLineDrawWidth = scr_draw_text_size(function,22,10)/6
	scr_draw_rectangle_style(statusLineDrawWidth,statusLineDrawHeight,statusLineLeft,statusLineUp,c_my_gray,c_my_gray_dark)
	scr_draw_with_up(function,obj_work_camera.x,obj_work_camera.y+(statusLineUp-6)*obj_work_camera.drawRelation,font_main,font_main_up,22,10,c_my_gray_dark,draw_get_alpha())
	
	if selecting[0] == noone{
		scr_draw_rectangle_style_back(8,8,statusLineLeft-10,statusLineUp+25,c_my_gray,c_my_gray_dark)
	}
	else{
		scr_draw_rectangle_style(8,8,statusLineLeft-10,statusLineUp+25-2,c_my_gray,c_my_gray_dark)
		scr_draw_with_up(string(selecting[0]),obj_work_camera.x-10*obj_work_camera.drawRelation,obj_work_camera.y-33*obj_work_camera.drawRelation,font_main,font_main_up,22,10,color,draw_get_alpha())
	}
	
	if selecting[1] == noone{
		scr_draw_rectangle_style_back(8,8,statusLineLeft+10,statusLineUp+25,c_my_gray,c_my_gray_dark)
	}
	else{
		scr_draw_rectangle_style(8,8,statusLineLeft+10,statusLineUp+25-2,c_my_gray,c_my_gray_dark)
		scr_draw_with_up(string(selecting[1]),obj_work_camera.x+10*obj_work_camera.drawRelation,obj_work_camera.y-33*obj_work_camera.drawRelation,font_main,font_main_up,22,10,color,draw_get_alpha())
	}
}


if animationStatus == "correct"{
	transparencyDinamic = ds_map_find_value(transparencyResult,"transparency")	
	transparencyStatus = ds_map_find_value(transparencyResult,"status")
	transparencyResult = scr_dinamic_change_transparency(transparencyDinamic,transparencyStatus,0.05,0,1)
	scr_draw_rectangle_style_alpha(statusDrawWidth,statusDrawHeight,statusLeft,statusUp,c_green,c_green,transparencyDinamic)
	if transparencyDinamic == 1{
		taskNow++
		if taskNow < 15{
			random_set_seed(generateSeed+taskNow)
			task = scr_generate_task()
			scr_render_task_button(task)
			selecting[0] = noone
			selecting[1] = noone
			obj_work_draw_interface.taskStatuses[taskNow] = "now"
			canBack = true
		}
		else{
			instance_destroy(obj_work_button)
			animationStatus = "end"
			move = 0
		}
	}
	if transparencyDinamic == 0 and canBack == true{
		animationStatus = "noone"
	}
	with obj_work_button{
		draw_set_alpha(1-obj_task_manager.transparencyDinamic)
	}
}

if animationStatus == "uncorrect"{
	transparencyDinamic = ds_map_find_value(transparencyResult,"transparency")	
	transparencyStatus = ds_map_find_value(transparencyResult,"status")
	transparencyResult = scr_dinamic_change_transparency(transparencyDinamic,transparencyStatus,0.05,0,1)
	scr_draw_rectangle_style_alpha(statusDrawWidth,statusDrawHeight,statusLeft,statusUp,c_red,c_red,transparencyDinamic)
	if transparencyDinamic == 1{
		taskNow++
		if taskNow < 15{
			random_set_seed(generateSeed+taskNow)
			task = scr_generate_task()
			scr_render_task_button(task)
			selecting[0] = noone
			selecting[1] = noone
			obj_work_draw_interface.taskStatuses[taskNow] = "now"
			canBack = true
		}
		else{
			instance_destroy(obj_work_button)
			animationStatus = "end"
			move = 0
		}
	}
	if transparencyDinamic == 0 and canBack == true{
		animationStatus = "noone"
	}
	with obj_work_button{
		draw_set_alpha(1-obj_task_manager.transparencyDinamic)
	}
}

if animationStatus == "end"{
	drawRectangleXStart = obj_work_camera.x-obj_work_camera.displayWidth
	drawRectangleYStart = obj_work_camera.y-obj_work_camera.displayHeight
	drawRectangleXEnd = obj_work_camera.x-obj_work_camera.displayWidth+move
	drawRectangleYEnd = obj_work_camera.y+obj_work_camera.displayHeight
	draw_rectangle_color(drawRectangleXStart,drawRectangleYStart,drawRectangleXEnd,drawRectangleYEnd,c_my_gray_dark,c_my_gray_dark,c_my_gray_dark,c_my_gray_dark,false)
	if obj_work_camera.displayWidth*2-move > 500{
		move+=(obj_work_camera.displayWidth*2-move)/32
	}
	else{
		transitBuffer = buffer_create(256, buffer_grow, 1)
		buffer_seek(transitBuffer, buffer_seek_start, 0)
		buffer_write(transitBuffer, buffer_string, "Task End")
		network_send_packet(global.client, transitBuffer, buffer_tell(transitBuffer))
		buffer_delete(transitBuffer)
		animationStatus = "wait"
	}
}

if animationStatus == "wait"{
	draw_rectangle_color(drawRectangleXStart,drawRectangleYStart,drawRectangleXEnd,drawRectangleYEnd,c_my_gray_dark,c_my_gray_dark,c_my_gray_dark,c_my_gray_dark,false)
	draw_text_color(obj_work_camera.x-256,obj_work_camera.y-128,"Ожидание других игроков...",c_white,c_white,c_white,c_white,1)
	draw_text_color(obj_work_camera.x-64,obj_work_camera.y-64,obj_work_draw_interface.timeDraw,c_white,c_white,c_white,c_white,1)
}