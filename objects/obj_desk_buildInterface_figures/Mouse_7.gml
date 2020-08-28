if selected == false{
	obj_desk_buildInterface_figures.selected = false
	selected = true
	obj_desk_buildInterface_controller.selectedId = id
	dinamicY = 0
	status = "Up"
	figure = obj_desk_figures_settings.setupFigures[type]
	obj_desk_buildInterface_controller.price = ds_map_find_value(figure,"price")
	obj_desk_buildInterface_controller.drawPrice = true
}