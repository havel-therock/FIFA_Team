#=
#   @author Mateusz Laskowski
=#
################# METHODS TO DO #################
################# ZAD1/ZAD2/ZAD3/ZAD4 #################
# Pkg.add("Gadfly")
# Pkg.add("Cairo")

module MyModule
using Gadfly
using Cairo
export ilorazyRoznicowe, warNewton, naturalna, rysujNnfx

function ilorazyRoznicowe(x::Vector{Float64}, f::Vector{Float64})
    # function calculating the Differential Quota
    # x - vector of length n + 1 containing nodes x0,..., xn
    # f - vector of length n + 1 containing interpolated values functions in nodes f(x0),...,f(xn)

    function _ilorazyRoznicowe(x::Vector{Float64}, f::Vector{Float64})
        # local recursive function

        lenOfVector = length(x)
        if lenOfVector == 1 
            return f[1]
        else 
            return  (_ilorazyRoznicowe(x[2:lenOfVector], f[2:lenOfVector]) - _ilorazyRoznicowe(x[1:lenOfVector - 1], f[1:lenOfVector - 1])) / (x[lenOfVector] - x[1])
        end
    end

    return [_ilorazyRoznicowe(x[1:index], f[1:index]) for index in 1:length(x)]
end

function warNewton(x::Vector{Float64}, fx::Vector{Float64}, t::Float64)
    # function calculating the value of the interpolative polynomial of degree n in Newton's form at the point x = t using the Horner algorithm
    # x - vector of length n + 1 containing nodes x0,..., xn
    # fx - vector of length n+1 containing the difference quotients fx [1] = f [x0],..., fx[n+1] = f[x0,..., xn]
    # t - point at which the polynomial value should be calculated

    function _warNewton(i::Int64)
        # local recursive function

        if i == length(x)
            return fx[i]
        else
            return fx[i] + (t - x[i]) * _warNewton(i + 1)
        end
    end

    return _warNewton(1)
end

function naturalna(x::Vector{Float64}, fx::Vector{Float64})
    # function calculating coefficients of interpolation polynomial in the form of Newton
    # x - vector of length n + 1 containing nodes x0,..., xn
    # fx - vector of length n+1 containing the difference quotients fx [1] = f [x0],..., fx[n+1] = f[x0,..., xn]

    n = length(x);
    a = Vector{Float64}(n)
    a[n] = fx[n]
    for i in (n-1):-1:1
        a[i] = fx[i]
        for k in i:1:(n-1)
        a[k] = a[k] - (x[i] * a[k+1])
        end
    end
    return a
end

function rysujNnfx(f, a::Float64, b::Float64, n::Int)
    # function interpolates the given function f(x) and then draws an interpolative polynomial and an interpolated function
    # f - function f(x) given as an anonymous function
    # a, b - interpolation interval
    # n - degree of interpolative polynomial

    h = ((b - a) / n)
    nodes = [a + k * h for k in 0:n]
    nodes_vals = [f(z) for z in nodes]
    quotients = ilorazyRoznicowe(nodes, nodes_vals)

    println("Generating plots...")

    delta = (b - a) / 100
    args = [a + k * delta for k in 1:100]

    fxNewton = [warNewton(nodes, quotients, t) for t in args]
    fx = [f(z) for z in args]
  
    p = plot(
        layer(
            x=args, 
            y=fx, 
            Geom.line, 
            Theme(
                default_color = color(colorant"green"), background_color = color(colorant"white")
                )
            ),
            layer(
                x=args,
                y=fxNewton,
                Geom.line,   
                Theme(
                    default_color = color(colorant"red"), background_color = color(colorant"white")
                )
            ),
            Guide.title("Plot for n = " * dec(n)),
            Coord.Cartesian(ymin=-1.0,ymax=3.0)
        )

    draw(PNG("myplot-" * dec(rand(1000:9999)) * "-" * dec(n) * ".png", 15cm, 15cm), p)
    println("Plots generated")
end

end     # ending module