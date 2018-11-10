#!/usr/bin/env julia

#@author: Niebieski-Kapturek, INF-FIFA-PPT-TEAM®
#@title: zad5

#Funkcja, licząca wyrażenie z zadania w arytmetyce Float32
function zad532(pn,r,i)
	pnext=(Float32)(pn+((Float32)(r*pn)*((Float32)(1.0-pn))))
	if (i<10)
		println(" $i:  $pn")
		zad532(pnext,r,i+1)
	end
	if (i<41 && i>9)
		println("$i:  $pn")
		zad532(pnext,r,i+1)
	end
end

#Funkcja, licząca wyrażenie z zadania w arytmetyce Float64
function zad564(pn,r,i)
	pnext=(Float64)(pn+((Float64)(r*pn)*((Float64)(1.0-pn))))
	if (i<10)
		println(" $i:  $pn")
		zad564(pnext,r,i+1)
	end
	if (i<41 && i>9)
		println("$i:  $pn")
		zad564(pnext,r,i+1)
	end
end

#Funkcja organizacyjna
function zad5()
	p0=0.01
	p10=0.722
	r=3.0

	zad532(p0,r,0)
	print("\nNIEWIELKA MODFIKACJA: \n")
	zad532(p10,r,10)

	print("\nZAD B) Float32\n")
	zad532(p0,r,0)
	print("\nZAD B) Float64\n")
	zad564(p0,r,0)
end

zad5()
