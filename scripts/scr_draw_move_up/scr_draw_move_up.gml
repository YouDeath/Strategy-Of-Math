parametrNow = argument0
howChange = argument1
parametrMax = argument2

resultMap = ds_map_create()

ds_map_add(resultMap,"end",true)

if parametrNow+howChange <= parametrMax{
	parametrNow+=howChange
	ds_map_set(resultMap,"end",false)
}

ds_map_add(resultMap,"parametr",parametrNow)

return resultMap