camera = camera_create()

displayWidth = 1920
displayHeight = 1080

window_set_size(displayWidth,displayHeight)

sizeX = displayWidth
sizeY = displayHeight

relationWidth = displayWidth/800
drawRelation = 0

if relationWidth >= 1.6 and relationWidth < 2.4{
	drawRelation = 1
}
else{
	if relationWidth >= 2.4{
		drawRelation = 2
	}
}
drawRelation+=3

x = sizeX/2
y = sizeY/2

vm = matrix_build_lookat(x, y, -10, x, y, 0, 0, 1, 0)
pm = matrix_build_projection_ortho(sizeX, sizeY, 1, 10000)
camera_set_view_mat(camera, vm)
camera_set_proj_mat(camera, pm)
room_set_view_enabled(room,true)
view_camera[view_current] = camera

surface_resize(application_surface, sizeX, sizeY);
display_reset(0, false);