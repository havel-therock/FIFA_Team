#=
#   @author Mateusz Laskowski
=#

################# DRAW PLOTS OF FUNCTIONS #################

include("zad1.jl");
using MyModule

function f(x)
    return exp(1) ^ x
end

function g(x)
    return (x^2) * sin(x)
end


for n in 5:5:15
    MyModule.rysujNnfx(f, 0.0, 1.0, n)
end

for n in 5:5:15
    MyModule.rysujNnfx(g, -1.0, 1.0, n)
end