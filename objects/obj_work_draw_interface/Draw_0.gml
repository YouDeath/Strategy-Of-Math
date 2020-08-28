time++
if time mod 60 == 0{
	secondNow = time/60-secondStart
	secondRemained = secondMax - secondNow


	minuteDraw = secondRemained div 60
	secondDraw = secondRemained-minuteDraw*60
	minuteDraw = string(minuteDraw)
	secondDraw = string(secondDraw)
	if string_length(secondDraw) == 1{
		secondDraw = "0"+secondDraw
	}
}
scr_draw_rectangle_style(statusDrawWidth,statusDrawHeight,statusLeft,statusUp,c_my_gray,c_my_gray_dark)
scr_draw_rectangle_style(timeDrawWidth,timeDrawHeight,timeLeft,timeUp,c_my_gray,c_my_gray_dark)

timeDraw = minuteDraw+":"+secondDraw

scr_draw_with_up(timeDraw,obj_work_camera.x+timeLeft*obj_work_camera.drawRelation,obj_work_camera.y+(timeUp-6)*obj_work_camera.drawRelation,font_main,font_main_up,22,10,c_my_gray_dark,1)


for(i = 0; i < 15; i++){
	taskStatusDrawWidth = 4
	taskStatusDrawHeight = 4
	taskStatusLeft = 105
	taskStatusUp = -69+i*10
	switch taskStatuses[i]{
		case "service":{
			colorMain = c_my_grey
			colorOther = c_my_grey_dark
			break
		}
		case "now":{
			colorMain = c_my_gold
			colorOther = c_my_gold_dark
			break
		}
		case "correct":{
			colorMain = c_my_green
			colorOther = c_my_green_dark
			break
		}
		case "uncorrect":{
			colorMain = c_my_red
			colorOther = c_my_red_dark
			break
		}
		case "undefinded":{
			colorMain = c_my_gray
			colorOther = c_my_gray_dark
			break
		}
	}
	scr_draw_rectangle_style(taskStatusDrawWidth,taskStatusDrawHeight,taskStatusLeft,taskStatusUp,colorMain,colorOther)
}