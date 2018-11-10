#!/usr/bin/env julia

#@author: Niebieski-Kapturek, INF-FIFA-PPT-TEAM®
#@title: zad4

# Użycie pakietu Polynomials dedykowanemu wielomianom
# Pkg.add("Polynomials")
using Polynomials;

# Wzięte z pliku wielomian.txt współczynniki wielomianu P(x):
pa=[1, -210.0, 20615.0,-1256850.0,
      53327946.0,-1672280820.0, 40171771630.0, -756111184500.0,
      11310276995381.0, -135585182899530.0,
      1307535010540395.0,     -10142299865511450.0,
      63030812099294896.0,     -311333643161390640.0,
      1206647803780373360.0,     -3599979517947607200.0,
      8037811822645051776.0,      -12870931245150988800.0,
      13803759753640704000.0,      -8752948036761600000.0,
      2432902008176640000.0]

# Wielomian P(x) do zadania drugiego (różni się drugim współczynnikiem)
pb=[1, -210.0 - 2.0^-32, 20615.0,-1256850.0,
      53327946.0,-1672280820.0, 40171771630.0, -756111184500.0,
      11310276995381.0, -135585182899530.0,
      1307535010540395.0,     -10142299865511450.0,
      63030812099294896.0,     -311333643161390640.0,
      1206647803780373360.0,     -3599979517947607200.0,
      8037811822645051776.0,      -12870931245150988800.0,
      13803759753640704000.0,      -8752948036761600000.0,
      2432902008176640000.0]

# Odwrócenie kolejności zapisu (funkcja Poly bierze współczynnik pierwszy do x^0, a nie do x^n)
pa=reverse(pa)
pb=reverse(pb)

# Stworzenie wielomianów
wielomianP=Poly(pa)
wielomianPb=Poly(pb)
wielomianp=wielomianp=poly([i for i in 1.0:20.0])

# Funkcja roots(x) - zwraca miejsca zerowe wielomianu x
	z=reverse(roots(wielomianP))
	zb=reverse(roots(wielomianPb))

function zad4roots()
	println("\nMiejsca zerowe wielomianu P: \n\n", z)
	println("\nMiejsca zerowe wielomianu Pb: \n\n", zb)

end

function zad4a()
	println("\n WIELOMIAN P(x): \n")
	for i=1:20
		# Funkcja polyval(P,x) - zwraca wartość P(x)
		println("|P(z($i))| = ", abs(polyval(wielomianP,z[i])),", |p(z($i))| = ", abs(polyval(wielomianp,z[i])), ", |z($i)-$i| = ", abs(z[i]-Float64(i)))
	end
end

function zad4b()
	println("\n WIELOMIAN Pb(x): \n")
	for i=1:20
		# Funkcja polyval(P,x) - zwraca wartość P(x)
		println("|Pb(z($i))| = ", abs(polyval(wielomianPb,zb[i])),", |p(z($i))| = ", abs(polyval(wielomianp,zb[i])), ", |z($i)-$i| = ", abs(zb[i]-Float64(i)))
	end
end

# Funkcja organizacyjna
function zad4()
	zad4roots()
	zad4a()
	zad4b()
end

zad4()
