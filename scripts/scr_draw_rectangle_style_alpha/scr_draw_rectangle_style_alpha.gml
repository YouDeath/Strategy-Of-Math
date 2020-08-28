drawWidth = argument0
drawHeight = argument1
left = argument2
up = argument3
colorDefault = argument4
colorNew = argument5
alpha = argument6

draw_set_alpha(alpha)

draw_rectangle_color(obj_work_camera.x-obj_work_camera.drawRelation*drawWidth+left*obj_work_camera.drawRelation,
obj_work_camera.y-obj_work_camera.drawRelation*drawHeight+up*obj_work_camera.drawRelation,
obj_work_camera.x+obj_work_camera.drawRelation*drawWidth+left*obj_work_camera.drawRelation,
obj_work_camera.y+obj_work_camera.drawRelation*drawHeight+up*obj_work_camera.drawRelation,
colorDefault,colorDefault,colorDefault,colorDefault,false)

draw_rectangle_color(obj_work_camera.x-obj_work_camera.drawRelation*drawWidth-1*obj_work_camera.drawRelation/2+left*obj_work_camera.drawRelation,
obj_work_camera.y-obj_work_camera.drawRelation*drawHeight+up*obj_work_camera.drawRelation,
obj_work_camera.x-obj_work_camera.drawRelation*drawWidth+left*obj_work_camera.drawRelation,
obj_work_camera.y+obj_work_camera.drawRelation*drawHeight+up*obj_work_camera.drawRelation,
colorNew,colorNew,colorNew,colorNew,false)

draw_rectangle_color(obj_work_camera.x+obj_work_camera.drawRelation*drawWidth+left*obj_work_camera.drawRelation,
obj_work_camera.y-obj_work_camera.drawRelation*drawHeight+up*obj_work_camera.drawRelation,
obj_work_camera.x+obj_work_camera.drawRelation*drawWidth+1*obj_work_camera.drawRelation/2+left*obj_work_camera.drawRelation,
obj_work_camera.y+obj_work_camera.drawRelation*drawHeight+up*obj_work_camera.drawRelation,
colorNew,colorNew,colorNew,colorNew,false)

draw_rectangle_color(obj_work_camera.x-obj_work_camera.drawRelation*drawWidth-1*obj_work_camera.drawRelation/2+left*obj_work_camera.drawRelation,
obj_work_camera.y+obj_work_camera.drawRelation*drawHeight+5*obj_work_camera.drawRelation/2+up*obj_work_camera.drawRelation,
obj_work_camera.x+obj_work_camera.drawRelation*drawWidth+1*obj_work_camera.drawRelation/2+left*obj_work_camera.drawRelation,
obj_work_camera.y+obj_work_camera.drawRelation*drawHeight+up*obj_work_camera.drawRelation,
colorNew,colorNew,colorNew,colorNew,false)

draw_rectangle_color(obj_work_camera.x-obj_work_camera.drawRelation*drawWidth-1*obj_work_camera.drawRelation/2+left*obj_work_camera.drawRelation,
obj_work_camera.y-obj_work_camera.drawRelation*drawHeight-1*obj_work_camera.drawRelation/2+up*obj_work_camera.drawRelation,
obj_work_camera.x+obj_work_camera.drawRelation*drawWidth+1*obj_work_camera.drawRelation/2+left*obj_work_camera.drawRelation,
obj_work_camera.y-obj_work_camera.drawRelation*drawHeight+up*obj_work_camera.drawRelation,
colorNew,colorNew,colorNew,colorNew,false)

draw_set_alpha(1)