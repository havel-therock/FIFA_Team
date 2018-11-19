#author: Jan Sieradzki
#nr_indeksu: 236441


module rootsMethods
export bisection, tangent, secant

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

#function that finds root of function by tangent Newton method
# IN
# f - given function f
# pf - given derivate of function f
# x0 - start approximation
#delta,epsilon - precisions of this function
#maxit - the limit of iterations
# OUT
# r - approximty of f(x) root
# v - value of f(r)
# it : ammount of iterations
# err : error sygnalization 	0 - method is concurrent	1 - didn't achieve wanted approximation 2 - derivate is near of zero 
function tangent(f::Function,pf::Function, x0::Float64, delta::Float64, epsilon::Float64, maxit::Int)
	 v = f(x0)            

   	 if(abs(v) < epsilon)    
     	 	return x0, v, 0, 0
   	 end

   	 if (abs(pf(x0)) < epsilon)     
      	 	return 2, 2, 2, 2
  	 end

    for it = 1 : maxit
       	 x1 = x0 - (v/pf(x0))  
      	 v = f(x1)           

         if(abs(x1 - x0) < delta || abs(v) < epsilon)   
         	return x1, v, it, 0
         end
         x0 = x1              
    end

    return 1, 1, 1, 1   
end

#function that swaps two values
function swap(x::Float64, y::Float64)
    temp = x
    x = y
    y = temp
end

#function that finds root of function by secant method
# IN
# f - given function f
# x0,x1 - start approximations
#delta,epsilon - precisions of this function
#maxit - the limit of iterations
# OUT
# r - approximty of f(x) root
# v - value of f(r)
# it : ammount of iterations
# err : error sygnalization 	0 - method is concurrent	1 - didn't achieve wanted approximation
function secant(f::Function,x0::Float64, x1::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    fx0 = f(x0)       
    fx1 = f(x1)        

    for it = 1 : maxit
        if (abs(fx0) > abs(fx1))   
            swap(x0,x1)            
            swap(fx0,fx1)
        end

        s = (x1 - x0)/(fx1 - fx0)
        x1 = x0
        fx1 = fx0
        x0 = x0 - (fx0 * s)         
        fx0 = f(x0)                 

        if (abs(x1 - x0) < delta || abs(fx0) < epsilon)   
            return x0, fx0, it, 0
        end
    end

    return 1, 1, 1, 1   
end

end
