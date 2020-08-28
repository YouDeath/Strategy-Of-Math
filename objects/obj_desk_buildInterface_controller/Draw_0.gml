image_index = obj_desk_camera.cameraDistance-1

staticX = obj_desk_camera.x+(obj_desk_camera.sizeX/2-64)*obj_desk_camera.cameraDistance
staticY = obj_desk_camera.y+(obj_desk_camera.sizeY/2-64)*obj_desk_camera.cameraDistance
			
drawX = staticX-obj_desk_selectedInterface_controller.dinamicX
drawY = staticY-obj_desk_selectedInterface_controller.dinamicY
x = drawX
y = drawY

if press == false{
	draw_sprite_ext(spr_build_but,0,drawX,drawY,obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,0,noone,1)
}
else{
	draw_sprite_ext(spr_build_but,1,drawX,drawY,obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,0,noone,1)
}

if buildInterfaceOpen == true{
	if initialized == false{
		if drawBuyX-(staticX-16*obj_desk_camera.cameraDistance) > 1{
			drawBuyX = (staticX-16*obj_desk_camera.cameraDistance)+(drawBuyX-staticX)/2*obj_desk_camera.cameraDistance
		}
		else{
			initialized = true
		}
	}
	else{
		drawBuyX = (staticX-16*obj_desk_camera.cameraDistance)
	}
	drawBuyY = obj_desk_camera.y+(obj_desk_camera.sizeY/2-160)*obj_desk_camera.cameraDistance
	draw_sprite_ext(spr_buy,0,drawBuyX,drawBuyY,obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,0,noone,1)
	draw_sprite_ext(spr_buy,0,drawBuyX,drawBuyY-56*obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,obj_desk_camera.cameraDistance,0,noone,1)
	scr_draw_numbers(string(obj_desk_client_controller.money),drawBuyX,drawBuyY-58*obj_desk_camera.cameraDistance,4*obj_desk_camera.cameraDistance)
	if drawPrice == true{
		scr_draw_numbers(string(price),drawBuyX,drawBuyY-2*obj_desk_camera.cameraDistance,4*obj_desk_camera.cameraDistance)
	}
}
