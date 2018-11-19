#=
#   @author Mateusz Laskowski
=#
################# CALCULATE f1(x) & f2(x) #################
include("zad1.jl")
using calculationMethods

function f1(x)
    return exp(1 - x) - 1
end

function pf1(x) 
    return (-1) * e^(1 - x)
end

function f2(x)
    return x * exp(-x)
end

function pf2(x)
    return ((-1) * (e)^((-1) * x) * (x - 1)) 
end

DELTA = 10.0^(-5)
EPSILON = 10.0^(-5)

## calculation for the first function
println("f1(x)")
println(calculationMethods.mbisekcji(f1, 0.0, 2.0, DELTA, EPSILON))
println(calculationMethods.mstycznych(f1, pf1, -0.5, DELTA, EPSILON, 1000))
println(calculationMethods.msiecznych(f1, 0.0, 2.0, DELTA, EPSILON, 1000))

## calculation for the second function
println("f2(x)")
println(calculationMethods.mbisekcji(f2, -1.0, 1.0, DELTA, EPSILON))
println(calculationMethods.mstycznych(f2, pf2, -0.5, DELTA, EPSILON, 1000))
println(calculationMethods.msiecznych(f2, -1.0, 1.0, DELTA, EPSILON, 1000))

println()
## Three experiments
## A
println("EXPERIMENT A")
for i = 1.1:0.3:20                      # change to more if u want check e.g 20 -> 1000
    print(i)
    print("\t")
    println(calculationMethods.mstycznych(f1, pf1, i, DELTA, EPSILON, 1000))
end

println()
## B
println("EXPERIMENT B")
for i = 1.1:0.3:20                       # change to more if u want check e.g 20 -> 1000
    print(i)
    print("\t")
    println(calculationMethods.mstycznych(f2, pf2, i, DELTA, EPSILON, 1000))
end

println()
## C
println("EXPERIMENT C")
println(calculationMethods.mstycznych(f2, pf2, 1.0, DELTA, EPSILON, 1000))