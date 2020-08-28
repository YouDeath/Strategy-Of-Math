figure = obj_desk_map.figuresArr[positionX,positionY]
show_debug_message(ds_map_find_value(figure,"type"))


obj_desk_client_controller.pressColor = obj_desk_client_controller.playersColorArr[owner]

drawStatuses = true

drawHp = true

steps = ds_map_find_value(figure,"step")
scr_linear_search_step(positionX,positionY,steps,"howerStep")

attackRadiusMin = ds_map_find_value(figure,"attackRadiusMin")
attackRadiusMax = ds_map_find_value(figure,"attackRadiusMax")
attackDMG = ds_map_find_value(figure,"attackDMG")	

scr_linear_search_attack(positionX,positionY,attackRadiusMin,attackRadiusMax,"howerAttack")
