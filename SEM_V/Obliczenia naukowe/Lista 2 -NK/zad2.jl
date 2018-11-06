#!/usr/bin/env julia

#@author: Niebieski-Kapturek, INF-FIFA-PPT-TEAM®
#@title: zad2

# Stworzenie logarytmu o podstawie e
function ln(x)
  return log(exp(1), x)
end

# Stworzenie funkcji z zadania
function f(x)
  return (exp(1)^x) * ln(1 + exp(-x))
end

# Wyświetlenie wyników
function zad2()
	for i=0:50
		println("$i, ", f(i))
	end
end

zad2()
