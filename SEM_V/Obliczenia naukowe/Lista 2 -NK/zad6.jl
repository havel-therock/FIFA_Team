#!/usr/bin/env julia

#@author: Niebieski-Kapturek, INF-FIFA-PPT-TEAM®
#@title: zad6

# Funkcja, wyliczająca rekurencyjnie problem z zadania w arytmetyce Float64
function wylicz(c, x, i)
	if (i==0)
	println("c = $c, x0 = $x\n")
	end
	xn=(Float64)((Float64)((Float64)(x)*((Float64)(x))) + (Float64)(c))
	if (i<41)
		println("$i  $x")
		wylicz(xn, c, i+1)
	end
end

# Funkcja organizacyjna
function zad6()
	wylicz(-2, 1.0, 0)
	println()
	wylicz(-2, 2.0, 0)
	println()
	wylicz(-2, 1.99999999999999, 0)
	println()
	wylicz(-1, 1.0, 0)
	println()
	wylicz(-1, -1.0, 0)
	println()
	wylicz(-1, 0.75, 0)
	println()
	wylicz(-1, 0.25, 0)
end

zad6()
