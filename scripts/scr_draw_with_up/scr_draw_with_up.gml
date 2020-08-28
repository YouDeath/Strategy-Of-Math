text = argument0
drawTextX = argument1
drawTextY = argument2
font = argument3
fontUp = argument4
letterSize = argument5
letterSizeUp = argument6
color = argument7
alpha = argument8

upper = false

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
				drawTextX-=letterSize/2
			}
			else{
				drawTextX-=letterSizeUp/2
			}
		}
	}
}

upper = false
upperHow = 0
serviceHow = 0

for(i = 0; i < string_length(text); i++){
	char = string_char_at(text,i+1)
	if char == "*"{
		upper = true
		serviceHow++
	}
	else{
		if char == "&"{
			upper = false
			serviceHow++
		}
		else{
			if upper = false{
				draw_set_font(font)
			}
			else{
				draw_set_font(fontUp)
			}
			drawTextLetterX = drawTextX+upperHow*letterSizeUp+(i-upperHow-serviceHow)*letterSize
			draw_text_color(drawTextLetterX,drawTextY,char,color,color,color,color,alpha)
			if upper = true{
				upperHow++
			}
		}
	}
}