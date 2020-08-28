transparencyNow = argument0
changeStatus = argument1
howChange = argument2
transparencyMin = argument3
transparencyMax = argument4

nextStatus = changeStatus

if changeStatus == "Up"{
	transparencyNow+=howChange
	if transparencyNow >= transparencyMax{
		nextStatus = "Down"
	}
}

if changeStatus == "Down"{
	transparencyNow-=howChange
	if transparencyNow <= transparencyMin{
		nextStatus = "Up"
	}
}

out_map = ds_map_create()
ds_map_add(out_map,"transparency",transparencyNow)
ds_map_add(out_map,"status",nextStatus)

return out_map