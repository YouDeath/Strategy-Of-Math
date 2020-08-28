// Сглаживание
MapInfoArr = scr_bin_smoothing(MapInfoArr,ds_map_find_value(global.settingsGame,"mapSizeX"), ds_map_find_value(global.settingsGame,"mapSizeY"),2,3,1)
MapInfoArr = scr_bin_smoothing(MapInfoArr,ds_map_find_value(global.settingsGame,"mapSizeX"), ds_map_find_value(global.settingsGame,"mapSizeY"),4,5,1)