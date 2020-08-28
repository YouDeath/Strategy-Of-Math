if obj_desk_client_controller.menuOpen == false{
	x+=10
	vm = matrix_build_lookat(x, y, -10, x, y, 0, 0, 1, 0)
	camera_set_view_mat(camera, vm)
}

if point_distance(backX,backY,x,y) > 32{
	needRender = true	
}