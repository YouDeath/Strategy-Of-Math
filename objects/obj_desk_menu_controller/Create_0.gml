maskReturn[1] = spr_menu_return_mask1
maskReturn[2] = spr_menu_return_mask2
maskReturn[3] = spr_menu_return_mask3

maskOut[1] = spr_menu_out_mask1
maskOut[2] = spr_menu_out_mask2
maskOut[3] = spr_menu_out_mask3


object_set_mask(obj_desk_menu_out,maskOut[obj_desk_camera.cameraDistance])
object_set_mask(obj_desk_menu_return,maskReturn[obj_desk_camera.cameraDistance])

instance_create_depth(x,y-120*obj_desk_camera.cameraDistance,-2,obj_desk_menu_return)
instance_create_depth(x,y+168*obj_desk_camera.cameraDistance,-2,obj_desk_menu_out)