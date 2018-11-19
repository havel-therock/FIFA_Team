#author: Jan Sieradzki
#nr_indeksu: 236441

include("rootsMethods.jl")
using rootsMethods

# Given function
f(x) = sin(x) - (0.5 * x)^2.0
#accurate of calculation
delta = 0.5 * 10.0^-5.0          
epsilon = 0.5 * 10.0^-5.0  

println("Method bisection: ")
(r,v,it,err) = bisection(f, 1.5, 2.0, delta, epsilon)
println("r: $(r)	v: $(v)		it: $(it)	err: $(err)")

println("Method tangent: ")
(r,v,it,err) = tangent(f, x -> cos(x) - 0.5 * x, 1.5, delta, epsilon, 50)
println("r: $(r)	v: $(v)		it: $(it)	err: $(err)")

println("Method secant: ")
(r,v,it,err) = secant(f, 1.0, 2.0, delta, epsilon, 50)
println("r: $(r)	v: $(v)		it: $(it)	err: $(err)")

