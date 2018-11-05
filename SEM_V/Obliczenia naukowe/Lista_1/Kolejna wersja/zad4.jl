#!/usr/bin/env julia

#@author: Niebieski Kapturek, INF-FIFA-PPT-TEAM®
#@title: zad4

# Podpunkt a "x * (1/x) =/= 1, 1<x<2" (najmniejsza z przedziału (1,2))

function zad4a()
x = Float64(1.0)

while Float64(x*Float64(1/x)) == 1.0
	x = nextfloat(Float64(x))
end
println("x = ", x)
end

# Podpunkt b "najmniejsza liczba" (najmniejsza w sensie modułu)

function zad4b()
x = nextfloat(Float64(0.0))

while Float64(x*Float64(1/x)) == 1.0
	x = nextfloat(Float64(x))
end
println("x = ", x)
end

# Podpunkt b "najmniejsza liczba" (najmniejsza w sensie w pobliżu -MAX)

function zad4c()
x = - realmax(Float64)

while Float64(x*Float64(1/x)) == 1.0
	x = nextfloat(Float64(x))
end
println("x = ", x)
end

zad4a()
zad4b()
zad4c()
