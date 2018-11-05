#!/usr/bin/env julia

#@author: Niebieski Kapturek, INF-FIFA-PPT-TEAM®
#@title: zad7

# Obliczenia w arytmetyce Float64

# Zadana funkcja f(x)=sin(x)+cos(3x)

function f(x)
    return Float64(Float64(sin(x)) + Float64(cos(3.0 * x)))
end

# Pochodna z definicji

function pochodnaf(x,h)
    return Float64( Float64(f(Float64(x+h)) - f(x)) / Float64(h) )
end

# Liczenie przybliżonych wartości pochodnej dla każdego h=2^-n (n = 0,1,..,54)

function wynikpochodnaf()
	for n = 0:54
    		println("h = 2^(-$n), f'(1) = ", pochodnaf(1,2.0^-n))
	end
end

# Dokładna pochodna funkcji f(x)=sin(x)+cos(3x) -> f'(x)=cos(x)-3sin(3x)

function dokladnapochodnaf(x)
    return cos(x) - 3.0 * sin(3.0 * x)
end

# Funkcja, wyświetlająca wynik dokładnej pochodnej f'(1)

function wynikdokladnapochodnaf()
    	println("dokładna f'(1) = ", dokladnapochodnaf(1))
end

# Liczenie błędu
function blad()
	for n = 0:54
		println("Błąd dla h=2^(-$n): ð = ", abs(pochodnaf(1,2.0^-n)-dokladnapochodnaf(1)))
	end
end

# Funkcja nawigacyjna
function zad7()
	println(" Zadanie 7: Wpisz funkcję")
	println("1) Przybliżone wartości f'(1) -> wynikpochodnaf()")
	println("2) Dokładna wartość pochodnej -> wynikdokladnapochodnaf()")
	println("3)      Błędy względne        -> blad()")
end

zad7()
