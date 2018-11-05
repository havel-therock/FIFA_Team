#!/usr/bin/env julia

#@author: Niebieski Kapturek, INF-FIFA-PPT-TEAM®
#@title: zad6

# Obliczenia wykonywane w arytmetyce Float64

# Funkcja, wyliczająca kwadrat danej liczby f(x)=x^2

function kwadrat(x)
	return x*x
end

# Implementacja funkcji f(x) z zadania

function f(x)
	return Float64(Float64(sqrt(Float64(kwadrat(Float64(x)))+1.0))-1.0)
end

# Implementacja funkcji g(x) z zadania

function g(x)
	return Float64(Float64(kwadrat(Float64(x))) / Float64((Float64(sqrt(Float64(kwadrat(Float64(x)))+1.0))+1.0)))
end

# Funkcja główna, wyliczająca wartości funkcji f(x) i g(x) dla argumentu x=8^(-i), i=1,2,..,15

function zad6()
	for i=1:15
		println("f(8^(-$i)) = ", f(8.0^(-i)))
		println("g(8^(-$i)) = ", g(8.0^(-i)))
	end
end

zad6()
