text = argument0
letterSize = argument1
letterSizeUp = argument2

upper = false
sizeTextX = 0

for(i = 0; i < string_length(text); i++){
	char = string_char_at(text,i+1)
	if char == "*"{
		upper = true
	}
	else{
		if char == "&"{
			upper = false
		}
		else{
			if upper = false{
				sizeTextX+=letterSize
			}
			else{
				sizeTextX+=letterSizeUp
			}
		}
	}
}

return sizeTextX