#!/usr/bin/env julia

#@author: Niebieski-Kapturek, INF-FIFA-PPT-TEAM®
#@title: zad2

# Dodawanie funkcji generujących
include("hilb.jl")
include("matcond.jl")

# Funkcja, licząca błędy względne
function delta(xf, x)
	return norm(xf-x)/norm(x)
end

# Funkcja, licząca Macierz Hilberta
function liczenieHilb()
	println(" MACIERZ HILBERTA")
	for i=1:20
		A = hilb(i)
		# ones((arytmetyka),x,y,..) - tworzy tablicę x×y×.. wypełnioną liczbami 1.0
		x = ones(i)
		b = A*x
		# eliminacja Gaussa
		xg = A\b
		# x=A^(-1)b inv(x) - inverse of x
		xinv = inv(A)*b

		println("i: $i, rząd macierzy: ", rank(A), ", wsk. uwarunkowania: ", cond(A), ", ð1: ", delta(xg, x), ", ð2: ", delta(xinv, x))
	end
end

# Funkcja, licząca losową macierz
function liczenieLos()
	println(" LOSOWA MACIERZ")
	for n in [5, 10, 20]
		for c in [1.0, 10.0, 10.0^3, 10.0^7, 10.0^12, 10.0^16]
			A = matcond(n,c)
			x = ones(n)
			b = A*x
			xg = A\b
			xinv = inv(A)*b

			println("n: $n, rząd macierzy: ", rank(A), ", wsk. uwarunkowania: ", c, ", ð1: ", delta(xg, x), ", ð2: ", delta(xinv, x))
		end
	end
end

# Funkcja organizacyjna
function zad3()
	liczenieHilb()
	liczenieLos()
end

zad3()
