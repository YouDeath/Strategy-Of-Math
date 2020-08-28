if obj_desk_camera.interfaceNeedUpdate == true{
	x = obj_desk_camera.x+obj_desk_camera.sizeX*obj_desk_camera.cameraDistance/2-(64+array_length_1d(playersColorArr)*48)*obj_desk_camera.cameraDistance
	y = obj_desk_camera.y-obj_desk_camera.sizeY*obj_desk_camera.cameraDistance/2+48*obj_desk_camera.cameraDistance
	interfaceNeedUpdate = false
}

for (i = 0; i < array_length_1d(playersColorArr); i++){
	if whoTurn == i{
		draw_sprite_ext(spr_who_turn,0,x+i*48*obj_desk_camera.cameraDistance,y+22*obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,0,noone,1)
		draw_sprite_ext(spr_who_turn,1,x+i*48*obj_desk_camera.cameraDistance,y+22*obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,0,playersColorArr[i],1)
		draw_sprite_ext(spr_who_turn,2,x+i*48*obj_desk_camera.cameraDistance,y+10*obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,0,noone,1)
	}
	else{
		draw_sprite_ext(spr_who_turn,0,x+i*48*obj_desk_camera.cameraDistance,y+8*obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,0,noone,1)
		draw_sprite_ext(spr_who_turn,1,x+i*48*obj_desk_camera.cameraDistance,y+8*obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,0,playersColorArr[i],1)
	}
}

if newTurn == true{
	
	drawStartY = obj_desk_camera.y-96*obj_desk_camera.cameraDistance
	drawEndY = obj_desk_camera.y+96*obj_desk_camera.cameraDistance
	
	if tick < 20{
		drawEndX = deltaFunction[0]*tick*tick+deltaFunction[1]*tick+deltaFunction[2]
	}
	else{
		if tick < 80 and tick > 40{
			iterator = tick-60
			drawStartX = deltaFunction[0]*iterator*iterator+deltaFunction[1]*iterator+deltaFunction[2]
		}
		else{
			if tick > 80{
				newTurn = false
			}
		}
	}
	tick++
	draw_set_alpha(0.5)
	draw_rectangle_color(obj_desk_camera.x+drawStartX*obj_desk_camera.cameraDistance,drawStartY,obj_desk_camera.x+drawEndX*obj_desk_camera.cameraDistance,drawEndY,c_black,c_black,c_black,c_black,false)
	draw_rectangle_color(obj_desk_camera.x+drawStartX*obj_desk_camera.cameraDistance,drawStartY,obj_desk_camera.x+drawEndX*obj_desk_camera.cameraDistance,drawEndY,playersColorArr[whoTurn],playersColorArr[whoTurn],playersColorArr[whoTurn],playersColorArr[whoTurn],false)
	draw_set_alpha(1)
}