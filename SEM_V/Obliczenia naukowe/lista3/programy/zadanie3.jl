#author: Jan Sieradzki
#nr_indeksu: 236441



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




