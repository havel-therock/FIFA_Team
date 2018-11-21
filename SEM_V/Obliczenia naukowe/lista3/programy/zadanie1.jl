#author: Jan Sieradzki
#nr_indeksu: 236441



#function that finds root of function by bisection method
# IN
# f - given function
# a,b - range [a,b], a and b must have diffrent signs
#delta,epsilon - precisions of this function
# OUT
# r - approximty of f(x) root
# v - value of f(r)
# it : ammount of iterations
# err : error sygnalization 	0 - succes 		1 - error
function bisection(f::Function,a::Float64, b::Float64, delta::Float64, epsilon::Float64)
	u=f(a)
	v=f(b)
	en=b-a
	if(sign(u) == sign(v))
		return f(a),f(b),1,1
	end 
	k=0 #iteration counter
	while (true)
		k+=1
		en = en/2
		c=a+en
		w=f(c)
		if (abs(en) < delta || abs(w) < epsilon) # checking end conditions
            		return c, w, k, 0
        	end
		if (sign(w) != sign(u))
            		b = c
            		v = w
        	else
            		a = c
            		u = w
		end
	end
end


