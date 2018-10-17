#=
#   @author Mateusz Laskowski
=#

################# OBLICZ W ARYTMETYCE FLOAT64 #################
i = 1;                                                                      # zmienna indeksowana
f = Float64(0.0);                                                           # zmienna, której przypisze się wartości funckji f
g = Float64(0.0);                                                           # zmienna, której przypisze się wartości funckji g
while (i < 20)
    x = Float64((1/8)^i);                                                   # zmienna 8^-i
    @printf("x = %e", x);
    println();
    f = Float64(sqrt(Float64(x^2) + Float64(1.0)) - Float64(1.0));
    @printf("f(x=8^-%.0f) = ", i);
    println(f);
    g = Float64(Float64(x^2) / Float64(Float64(sqrt(Float64(x^2) + Float64(1.0))) + Float64(1.0)))
    @printf("g(x=8^-%.0f) = ", i);
    println(g);
    i = i+1;
    println()
end