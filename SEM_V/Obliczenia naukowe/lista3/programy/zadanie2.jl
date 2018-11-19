#author: Jan Sieradzki
#nr_indeksu: 236441



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




