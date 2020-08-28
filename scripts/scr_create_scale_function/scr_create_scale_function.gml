Xs = argument0
Ys = argument1

beta = (Xs[0]*(Xs[1]-Xs[0]))/(Xs[2]*(Xs[1]-Xs[2]))
alpha = (Xs[0]-beta*Xs[2])/Xs[1]
	 
outArr[2] = (Ys[0]-alpha*Ys[1]-beta*Ys[2])/(1-alpha-beta)
outArr[1] = (Xs[0]*Xs[0]*Ys[1]-Xs[1]*Xs[1]*Ys[0]-outArr[2]*Xs[0]*Xs[0]+outArr[2]*Xs[1]*Xs[1])/(Xs[1]*(Xs[0]*Xs[0]-Xs[1]*Xs[0]))
outArr[0] = (Ys[0]-outArr[1]*Xs[0]-outArr[2])/(Xs[0]*Xs[0])


return outArr