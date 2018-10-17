#=
#   @author Mateusz Laskowski
=#

################# ZNAJDŹ LICZBĘ W FLOAT64 #################

# Podpunkt A
println("Podpunkt A");
#=
x = Float64(1.0);
eta = nextfloat(Float64(1.0)) - Float64(1.0);
while (Float64(x * Float64(1.0 / x)) == 1.0 && Float64(x) < 2)
    x = x + eta;
end
println("x = ", x);                                             # x = 1.000000057228997
=#
# Podpunkt B
println("Podpunkt B");
x = realmin(Float64);
while (Float64(x * Float64(1.0 / x)) == 1.0)
    x = Float64(x + (nextfloat(x) - Float64(x)));
end
println("xmin = ", x);                                          # xmin = 2.225073985845947e-308