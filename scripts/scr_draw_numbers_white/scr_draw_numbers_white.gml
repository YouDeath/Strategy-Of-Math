what = argument0
thereX = argument1
thereY = argument2
scaleParametr = argument3

less = 0

for (i = 0; i < string_length(what); i++){
	numberPosition = i-((string_length(what)-1)/2)
	number = real(string_char_at(what,i+1))
	
	drawXNumber = thereX+(numberPosition*5-2*less)*scaleParametr
	drawYNumber = thereY
	if number == 1{
		less++
	}
	
	draw_sprite_ext(spr_numbers_white,number,drawXNumber,drawYNumber,scaleParametr,scaleParametr,0,noone,1)
}