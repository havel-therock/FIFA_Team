#=
#   @author Mateusz Laskowski
=#
################# USE METHODS #################
include("zad1.jl")

using calculationMethods

function f(x::Float64)
    return sin(x) - (0.5 * x)^(2.0)
end

function pf(x::Float64)
    return cos(x) - (0.5 * x)
end

DELTA = 0.5 * 10.0^(-5)
EPSILON = 0.5 * 10.0^(-5)

println(calculationMethods.mbisekcji(f, 1.5, 2.0, DELTA, EPSILON))
println(calculationMethods.mstycznych(f, pf, 1.5, DELTA, EPSILON, 1000))
println(calculationMethods.msiecznych(f, 1.0, 2.0, DELTA, EPSILON, 1000))