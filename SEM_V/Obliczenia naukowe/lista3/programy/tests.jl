#author: Jan Sieradzki
#nr_indeksu: 236441

include("rootsMethods.jl")
using rootsMethods

f(x) = x^3-x-2
g(x) = x^3 + x^2 - 5
ff(x) = 3*(x^2)-1
gg(x) = 3*(x^2) + 2*x

delta = 10.0^-5.0
epsilon = 10.0^-5.0
max = 50

println("x^3-x-2")

println("Method bisection: ")
(r,v,it,err) = bisection(f, 1.0, 2.0, delta, epsilon)
println("r: $(r)	v: $(v)		it: $(it)	err: $(err)")

println("Method tangent: ")
(r,v,it,err) = tangent(f, ff, 1.0, delta, epsilon, max)
println("r: $(r)	v: $(v)		it: $(it)	err: $(err)")

println("Method secant: ")
(r,v,it,err) = secant(f, 1.0, 5.0, delta, epsilon, max)
println("r: $(r)	v: $(v)		it: $(it)	err: $(err)")
println()


println("x^3 + x^2 - 5")

println("Method bisection: ")
(r,v,it,err) = bisection(g, 0.0, 4.0, delta, epsilon)
println("r: $(r)	v: $(v)		it: $(it)	err: $(err)")

println("Method tangent: ")
(r,v,it,err) = tangent(g, gg, 0.5, delta, epsilon, max)
println("r: $(r)	v: $(v)		it: $(it)	err: $(err)")

println("Method secant: ")
(r,v,it,err) = secant(g, 0.0, 4.5, delta, epsilon, max)
println("r: $(r)	v: $(v)		it: $(it)	err: $(err)")
println()

println("error test for : x^3 + x^2 - 5")

println("Method bisection: ")
(r,v,it,err) = bisection(g, 3.0, 4.0, delta, epsilon)
println("r: $(r)	v: $(v)		it: $(it)	err: $(err)")

println("Method tangent: ")
(r,v,it,err) = tangent(g, gg, -60455635.5, delta, epsilon, max)
println("r: $(r)	v: $(v)		it: $(it)	err: $(err)")

println("Method secant: ")
(r,v,it,err) = secant(g, -5.0, -6.5, delta, epsilon, max)
println("r: $(r)	v: $(v)		it: $(it)	err: $(err)")
