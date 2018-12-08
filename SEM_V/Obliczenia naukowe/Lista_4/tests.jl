#=
#   @author Mateusz Laskowski
=#
################# TESTS TO #################
################# ZAD1/ZAD2/ZAD3/ZAD4 #################

include("zad1.jl");

using MyModule
using Base.Test

function compare(valueToCheck, expectedValue)
  for (index, number) in enumerate(valueToCheck)
    #@test number ≈ expectedValue[index] atol=ε
    println(expectedValue[index])
  end
end

ε = 0.001
x = [-2.0, -1.0, 0.0, 1.0, 2.0, 3.0]
f = [-25.0, 3.0, 1.0, -1.0, 27.0, 235.0]

#@test MyModule.ilorazyRoznicowe(x, f) == [-25.0, 28.0, -15.0, 5.0, 0.0, 1.0]
println("ilorazyRoznicowe")
println("x = [-2.0, -1.0, 0.0, 1.0, 2.0, 3.0] | f = [-25.0, 3.0, 1.0, -1.0, 27.0, 235.0]")
println("ilorazyRoznicowe(x, f) =? [-25.0, 28.0, -15.0, 5.0, 0.0, 1.0]")
println(MyModule.ilorazyRoznicowe(x, f) == [-25.0, 28.0, -15.0, 5.0, 0.0, 1.0])
println()

#@test MyModule.warNewton([1.0, 2.0, 3.0, 4.0, 5.0, 6.0], [1.0, 2.74953, -3.30607, 3.035, -0.885002, 0.124822], 1.0) == 1.0
#@test MyModule.warNewton([1.0, 2.0, 3.0, 4.0, 5.0, 6.0], [1.0, 2.74953, -3.30607, 3.035, -0.885002, 0.124822], -2.0) ≈ -862.17359 atol=ε
#@test MyModule.warNewton([1.0, 2.0, 3.0, 4.0, 5.0, 6.0], [1.0, 2.74953, -3.30607, 3.035, -0.885002, 0.124822], 5.0) ≈ 23.9252 atol=ε

println("warNewton")
println(MyModule.warNewton([1.0, 2.0, 3.0, 4.0, 5.0, 6.0], [1.0, 2.74953, -3.30607, 3.035, -0.885002, 0.124822], 1.0))
println(MyModule.warNewton([1.0, 2.0, 3.0, 4.0, 5.0, 6.0], [1.0, 2.74953, -3.30607, 3.035, -0.885002, 0.124822], -2.0))
println(MyModule.warNewton([1.0, 2.0, 3.0, 4.0, 5.0, 6.0], [1.0, 2.74953, -3.30607, 3.035, -0.885002, 0.124822], 5.0))
println()

println("compare naturalna")
compare(MyModule.naturalna([1.0, 2.0, 3.0, 4.0, 5.0, 6.0], [1.0, 2.74953, -3.30607, 3.035, -0.885002, 0.124822]),
    [-62.7904, 124.504, -80.5761, 22.4949, -2.75733, 0.124822])
println()

wezly = [-1.0, 0.0, 1.0, 2.0]
wartosci = [-1.0, 0.0, -1.0, 2.0]

ilorazy = MyModule.ilorazyRoznicowe(wezly, wartosci)

println("naturalna")
println(MyModule.naturalna(wezly, ilorazy))