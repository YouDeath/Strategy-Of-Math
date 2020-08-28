taskNew = ds_map_create()
ready = false
while ready == false{
	solution1 = irandom(20)
	solution2 = irandom(20)
	if solution1 != solution2{
		ready = true
	}
}
ready = false
b = -(solution1+solution2)
c = solution1*solution2
ds_map_add(taskNew,"solution1",solution1)
ds_map_add(taskNew,"solution2",solution2)

function = "x*2&"
if sign(b) == -1{
	function+="-"+string(abs(b))+"x"
}
else{
	function+="+"+string(b)+"x"
}
function+="+"+string(c)
ds_map_add(taskNew,"function",function)

ds_map_add(taskNew,"answer1",string(solution1)+";"+string(solution2))
ds_map_add(taskNew,"answer2",string(solution2)+";"+string(solution1))

ds_map_add(taskNew,"name","Корни многочлена")

while ready == false{
	solution1X = irandom(4)
	solution1Y = irandom(1)

	solution2X = irandom(4)
	solution2Y = irandom(1)
	if solution1X != solution2X or solution1Y != solution2Y{
		ready = true
	}
}

for(ini = 0; ini < 5; ini++){
	for (inj = 0; inj < 2; inj++){
		options[ini,inj] = noone
	}
}

ready = false

options[solution1X,solution1Y] = solution1
options[solution2X,solution2Y] = solution2
for(ini = 0; ini < 5; ini++){
	for (inj = 0; inj < 2; inj++){
		if options[ini,inj] == noone{
			while ready == false{
				ready = true
				options[ini,inj] = irandom(40)
				for (zi = 0; zi < 5; zi++){
					for (zj = 0; zj < 2; zj++){
						if !(zi == ini and zj == inj) and options[ini,inj] == options[zi,zj]{
							ready = false
							break
						}
					}
				}
			}
		}
		ready = false
	}
}

ds_map_add(taskNew,"options",options)

return taskNew