#=
#   @author Mateusz Laskowski
=#

################# PRZYBLIŻONA WARTOŚĆ POCHODNEJ #################

function pochodnaP(x, h)
    return Float64(Float64(sin(Float64(x + h)) + cos(Float64(3 * (x + h)))) - Float64(sin(Float64(x)) + cos(Float64(3 * x))) / Float64(h));
end

# pochodna f'(x) = cos(x) - 3*sin(3*x)

function blad(x, w)
    return abs(Float64(Float64(cos(Float64(x))) - Float64(3 * sin(Float64(3 * x)))) - w);
end

n = 0;
wynik = Float64(0.0);
# println(Float64(sin(Float64(1.0)) + cos(Float64(3 * 1.0))))
# println(Float64(sin(Float64(2.0)) + cos(Float64(3 * 2.0))))

while (n <= 54)
    h = Float64(1.0 / (2.0^n));
    wynik = pochodnaP(1.0, h);
    println("h = 2^-", n);
    println("h = ", h , "  ||  ~f'(x) = ", wynik);
    println("1 + h = ", Float64(1.0 + h));
    println("f'(x) = ", Float64(Float64(cos(Float64(1.0))) - Float64(3 * sin(Float64(3 * 1.0)))))
    println("Błąd = ", blad(1.0, wynik));
    n = n + 1;
end
