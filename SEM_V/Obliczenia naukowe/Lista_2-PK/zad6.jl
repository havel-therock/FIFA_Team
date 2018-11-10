#@author: Piotr Klepczyk

#x(n+1)=x^2(n)+c

#=
get result for recursive equation in Float64
@par x0 - value for x(0)
@par c - constant
@par n - number of iteration
=#
function calc_f64(x0,c,n)
    x = Float64((x0^2)+c)
    println(Float64(x))
    n=n-1
    if n>0
        calc_f64(x,c,n)
    end
end

#1:
println("1:")
calc_f64(1.0,-2,40)
println()

#2:
println("2:")
calc_f64(2.0,-2,40)
println()

#3:
println("3:")
calc_f64(1.99999999999999,-2,40)
println()

#4:
println("4:")
calc_f64(1.0,-1,40)
println()

#5:
println("5:")
calc_f64(-1.0,-1,40)
println()

#6:
println("6:")
calc_f64(0.75,-1,40)
println()

#7:
println("7:")
calc_f64(0.25,-1,40)
println()