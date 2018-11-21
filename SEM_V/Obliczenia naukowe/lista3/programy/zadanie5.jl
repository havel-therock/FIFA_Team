#author: Jan Sieradzki
#nr_indeksu: 236441

include("rootsMethods.jl")
using rootsMethods

# Roots of function f(x) are the place where functions y = 3x and y = e^x cross eachother
f(x) = e^x - 3.0 * x

# Accurate :
delta = 10.0^-4.0         
epsilon = 10.0^-4.0      

# There are two roots of that function, one in [0,1] and second in [1,3]
println("[0,1]")
(r,v,it,err) = bisection(f, 0.0, 1.0, delta, epsilon)
println("r: $(r)	v: $(v)		it: $(it)	err: $(err)")
println("[1,3]")
(r,v,it,err) = bisection(f, 1.0, 2.0, delta, epsilon) 
println("r: $(r)	v: $(v)		it: $(it)	err: $(err)")

