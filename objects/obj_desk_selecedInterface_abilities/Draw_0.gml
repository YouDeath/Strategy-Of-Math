staticX = obj_desk_camera.x-(obj_desk_camera.sizeX/2-256)*obj_desk_camera.cameraDistance+40*(type-2)*obj_desk_camera.cameraDistance
staticY = obj_desk_camera.y+(obj_desk_camera.sizeY/2-40)*obj_desk_camera.cameraDistance-8*obj_desk_camera.cameraDistance

mask_index = maskArr[obj_desk_camera.cameraDistance]

drawX = staticX-dinamicX
drawY = staticY-dinamicY
x = drawX
y = drawY
	
if tick < 20{
	dinamicY = scaleFunctionParametrs[0]*tick*tick+scaleFunctionParametrs[1]*tick+scaleFunctionParametrs[2]
	dinamicX = 0
	tick++
}
else{
	dinamicX = 0
	dinamicY = 0
}

positionX = obj_desk_selectedInterface_controller.selectedX
positionY = obj_desk_selectedInterface_controller.selectedY
figure = obj_desk_map.figuresArr[positionX,positionY]

if type == 0{
	if ds_map_find_value(figure,"hp") == ds_map_find_value(figure,"hpMax"){
		canPress = false
	}
	else{
		canPress = true
	}
}

if type == 1{
	if ds_map_find_value(figure,"stepCan") == false{
		canPress = false
	}
	else{
		canPress = true
	}
}

if type == 2{
	if ds_map_find_value(figure,"attackCan") == false{
		canPress = false
	}
	else{
		canPress = true
	}
}

if press == false{
	draw_sprite_ext(spr_character_abilities,type*2,drawX,drawY,obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,0,noone,1)
}
else{
	draw_sprite_ext(spr_character_abilities,type*2+1,drawX,drawY,obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,0,noone,1)
}

if canPress == false{
	draw_sprite_ext(spr_character_abilities,type+10,drawX,drawY,obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,0,noone,1)
}

if timer == true and time > room_speed*0.5{
	if type < 3{
		draw_sprite_ext(spr_character_abilities,type+13,drawX,drawY-40*obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,0,noone,1)
		if type == 0{
			scr_draw_numbers_white(string(ds_map_find_value(figure,"hp")),drawX,drawY-45*obj_desk_camera.cameraDistance,2*obj_desk_camera.cameraDistance)
		}
		if type == 1{
			scr_draw_numbers_white(string(ds_map_find_value(figure,"step")),drawX,drawY-45*obj_desk_camera.cameraDistance,2*obj_desk_camera.cameraDistance)
		}
		if type == 2{
			scr_draw_numbers_white(string(ds_map_find_value(figure,"attackDMG")),drawX,drawY-45*obj_desk_camera.cameraDistance,2*obj_desk_camera.cameraDistance)
		}
	}
}
time++