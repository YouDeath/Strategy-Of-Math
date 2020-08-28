if press == false{
	draw_sprite(spr_work_button,type*2,x,y)
}
else{
	draw_sprite(spr_work_button,type*2+1,x,y)
}

if type == 2{
	color = obj_task_manager.c_my_gray_dark
	if press == false{
		scr_draw_with_up(string(number),x,y-28,font_main,font_main_up,22,10,color,draw_get_alpha())
	}
	else{
		scr_draw_with_up(string(number),x,y-20,font_main,font_main_up,22,10,color,draw_get_alpha())
	}
}