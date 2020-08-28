secondStart = 0
secondNow = 0
secondMax = 320
secondRemained = secondMax
time = 0

minuteDraw = secondRemained div 60
secondDraw = secondRemained-minuteDraw*60
minuteDraw = string(minuteDraw)
secondDraw = string(secondDraw)
	
for(i = 0; i < 15; i++){
	taskStatuses[i] = "undefinded"
}

taskStatuses[0] = "now"

c_my_gray = make_color_rgb(200,200,200)
c_my_gray_dark = make_color_rgb(100,100,100)
statusDrawWidth = 6
statusDrawHeight = 77
statusLeft = 105
statusUp = 2

timeDrawWidth = 18
timeDrawHeight = 6
timeLeft = -115
timeUp = -69

c_my_red = make_color_rgb(237,28,36)
c_my_red_dark = make_color_rgb(136,0,21)

c_my_green = make_color_rgb(14,221,34)
c_my_green_dark = make_color_rgb(10,150,23)

c_my_gold = make_color_rgb(255,203,21)
c_my_gold_dark = make_color_rgb(225,174,0)

c_my_grey = make_color_rgb(110,110,110)
c_my_grey_dark = make_color_rgb(65,65,65)