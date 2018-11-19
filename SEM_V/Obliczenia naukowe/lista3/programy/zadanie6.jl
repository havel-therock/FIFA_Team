#author: Jan Sieradzki
#nr_indeksu: 236441

# Functions :
f(x) = e^(1.0 - x) - 1.0
g(x) = x * e^(-x)

# Derivate
pf(x) = -e^(1.0 - x)
pg(x) = e^-x - x * e^-x

# Accurate :
delta = 10.0^-5.0               
epsilon = 10.0^-5.0  
 
# Max ammount of iterations :         
max = 50                   
maxit = 50000
println("f(x) = e^(1-x)-1: ")


println("Method bisection: ")
(r,v,it,err) = bisection(f, 0.0, 2.0, delta, epsilon)
println("0.0 i 2.0\t$(r)\t$(v)\t$(it)\t$(err)")
(r,v,it,err) = bisection(f, 0.5, 2.0, delta, epsilon)
println("0.5 i 2.0\t$(r)\t$(v)\t$(it)\t$(err)")

println("Method tangent: ")
(r,v,it,err) = tangent(f, pf, 0.0, delta, epsilon, maxit)
println("0.0\t$(r)\t$(v)\t$(it)\t$(err)")
(r,v,it,err) = tangent(f, pf, 2.0, delta, epsilon, maxit)
println("2.0\t$(r)\t$(v)\t$(it)\t$(err)")
(r,v,it,err) = tangent(f, pf, 7.0, delta, epsilon, maxit)
println("7.0\t$(r)\t$(v)\t$(it)\t$(err)")

println("Method secant: ")
(r,v,it,err) = secant(f, 0.0, 2.0, delta, epsilon, maxit)
println("0.0 i 2.0\t$(r)\t$(v)\t$(it)\t$(err)")


println("g(x) = xe^-x: ")

println("Method bisection: ")
(r,v,it,err) = bisection(g, -1.0, 1.0, delta, epsilon)
println("-1.0 i 1.0\t$(r)\t$(v)\t$(it)\t$(err)")
(r,v,it,err) = bisection(g, -0.5, 1.0, delta, epsilon)
println("-0.5 i 1.0\t$(r)\t$(v)\t$(it)\t$(err)")

println("Method tangent: ")
(r,v,it,err) = tangent(g, pg, -1.0, delta, epsilon, maxit)
println("-1.0\t$(r)\t$(v)\t$(it)\t$(err)")
(r,v,it,err) = tangent(g, pg, 2.0, delta, epsilon, maxit)
println("2.0\t$(r)\t$(v)\t$(it)\t$(err)")
(r,v,it,err) = tangent(g, pg, 10.0, delta, epsilon, maxit)
println("10.0\t$(r)\t$(v)\t$(it)\t$(err)")
(r,v,it,err) = tangent(g, pg, 1.0, delta, epsilon, maxit)
println("1.0\t$(r)\t$(v)\t$(it)\t$(err)")

println("Method secant: ")
(r,v,it,err) = secant(g, -1.0, 1.0, delta, epsilon, maxit)
println("-1.0 i 1.0\t$(r)\t$(v)\t$(it)\t$(err)")

