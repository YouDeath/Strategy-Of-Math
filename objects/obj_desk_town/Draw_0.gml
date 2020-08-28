draw_sprite(spr_town_stand,0,x,y-6)
draw_sprite(spr_town,0,x,y)
draw_sprite_ext(spr_town,1,x,y,1,1,0,color,1)

depth = layer_get_depth(layer_get_id("IngameCells"))-positionX-positionY

if selected == true{
	transparencyDinamic = ds_map_find_value(transparencyResult,"transparency")
	draw_sprite_ext(spr_town,2,x,y,1,1,0,noone,transparencyDinamic)
	transparencyStatus = ds_map_find_value(transparencyResult,"status")
	transparencyResult = scr_dinamic_change_transparency(transparencyDinamic,transparencyStatus,0.04,0,1)
}
else{
	if obj_desk_mouse_controller.idOfSelectedObject == id{
		draw_sprite(spr_town,2,x,y)
	}
}