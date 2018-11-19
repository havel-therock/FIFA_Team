#=
#   @author Mateusz Laskowski
=#

################# DRAW PLOT OF THE FUNCTION #################
include("zad1.jl")
# using Plots
using calculationMethods

# in = linspace(-3, 5, 20)

function f(x)
  return (3x - exp(x))
end

# arr = [f(x) for x = in]

# plot(arr)

# png("juliaplot")

DELTA = 10.0^(-4)
EPSILON = 10.0^(-4)

println(calculationMethods.mbisekcji(f, 0.0, 1.0, DELTA, EPSILON))
println(calculationMethods.mbisekcji(f, 1.0, 2.0, DELTA, EPSILON))


