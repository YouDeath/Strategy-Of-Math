camera = camera_create()

displayWidth = 1920
displayHeight = 1080

sizeX = displayWidth
sizeY = displayHeight

x = sizeX/2
y = sizeY/2

camera = camera_create()
show_debug_message(sizeX)
show_debug_message(sizeY)
vm = matrix_build_lookat(x, y, -1000, x, y, 0, 0, 1, 0)
pm = matrix_build_projection_ortho(sizeX, sizeY, 1, 32000)
camera_set_view_mat(camera, vm)
camera_set_proj_mat(camera, pm)

surface_resize(application_surface, sizeX, sizeY);
display_reset(0, false);

view_camera[0] = camera

needRender = true
rendering = false
interfaceNeedUpdate = true
cameraChange = false
backX = -100
backY = -100
cameraDistance = 1

maskArr[1] = spr_menu_but_mask1
maskArr[2] = spr_menu_but_mask2
maskArr[3] = spr_menu_but_mask3

maskArr[4] = spr_end_turn_mask1
maskArr[5] = spr_end_turn_mask2
maskArr[6] = spr_end_turn_mask3

maskArr[10] = spr_desk_figure_mask1
maskArr[11] = spr_desk_figure_mask2
maskArr[12] = spr_desk_figure_mask3

instance_create_layer(x,y,"Interface",obj_desk_menu)