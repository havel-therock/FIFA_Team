#=
#   @author Mateusz Laskowski
=#

################# DRAW PLOTS OF FUNCTIONS #################

include("zad1.jl");
using MyModule

function f(x)
    return abs(x)
end

function g(x)
    return 1 / (1 + x ^ 2)
end


for n in 5:5:15
    MyModule.rysujNnfx(f, -1.0, 1.0, n)
end

for n in 5:5:15
    MyModule.rysujNnfx(g, -5.0, 5.0, n)
end