#!/usr/bin/env julia

#@author: Niebieski Kapturek, INF-FIFA-PPT-TEAM®
#@title: zad5

# Tworzenie wektorów

x = [2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
y = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

# Wyliczanie pojedynczych mnożeń (podpunkt c) i d))

S1s = Float32(Float32(x[1]) * Float32(y[1]))
S2s = Float32(Float32(x[2]) * Float32(y[2]))
S3s = Float32(Float32(x[3]) * Float32(y[3]))
S4s = Float32(Float32(x[4]) * Float32(y[4]))
S5s = Float32(Float32(x[5]) * Float32(y[5]))
S1d = Float64(Float64(x[1]) * Float64(y[1]))
S2d = Float64(Float64(x[2]) * Float64(y[2]))
S3d = Float64(Float64(x[3]) * Float64(y[3]))
S4d = Float64(Float64(x[4]) * Float64(y[4]))
S5d = Float64(Float64(x[5]) * Float64(y[5]))

# Podpunkt a) "w przód"

function zad5a32()
    S = Float32(0.0)
    for i=1:5
        S=Float32(S+Float32(Float32(x[i])*Float32(y[i])))
    end
    return S
end
function zad5a64()
    S = Float64(0.0)
    for i=1:5
        S=Float64(S+Float64(Float64(x[i])*Float64(y[i])))
    end
    return S
end
function zad5a()
	println("Algorytm A: \n pojedyncza precyzja: S = ", zad5a32())
	println(" podwójna precyzja: S = ", zad5a64())
end

# Podpunkt b) "w tył"

function zad5b32()
    S = Float32(0.0)
    for i=1:5
        S=Float32(S+Float32(Float32(x[6-i])*Float32(y[6-i])))
    end
    return S
end
function zad5b64()
    S = Float64(0.0)
    for i=1:5
        S=Float64(S+Float64(Float64(x[6-i])*Float64(y[6-i])))
    end
    return S
end
function zad5b()
	println("Algorytm B: \n pojedyncza precyzja: S = ", zad5b32())
	println(" podwójna precyzja: S = ", zad5b64())
end

# Funkcja wypisująca wyniki poszczególnych mnożeń

function mnozenia32()
	println("Mnożenia - pojedyncza precyzja:")
        println("x[1]*y[1] = ",S1s)
        println("x[2]*y[2] = ",S2s)
	println("x[3]*y[3] = ",S3s)
	println("x[4]*y[4] = ",S4s)
	println("x[5]*y[5] = ",S5s)
end
function mnozenia64()
	println("Mnożenia - podwójna precyzja:")
        println("x[1]*y[1] = ",S1d)
        println("x[2]*y[2] = ",S2d)
	println("x[3]*y[3] = ",S3d)
	println("x[4]*y[4] = ",S4d)
	println("x[5]*y[5] = ",S5d)
end
function mnozenia()
	mnozenia32()
	mnozenia64()
end

# S4 > S1 > S5 > 0 > S3 > S2

# Podpunkt c) "od największego do najmniejszego"

function zad5c32()
	Splus = Float32(Float32(S4s+S1s)+S5s)
	Sminus = Float32(S2s+S3s)
	S = Float32(Splus+Sminus)
    return S
end
function zad5c64()
	Splus = Float64(Float64(S4d+S1d)+S5d)
	Sminus = Float64(S2d+S3d)
	S = Float64(Splus+Sminus)
    return S
end
function zad5c()
	println("Algorytm C: \n pojedyncza precyzja: S = ", zad5c32())
	println(" podwójna precyzja: S = ", zad5c64())
end

# Podpunkt d) "od najmniejszego do największego"

function zad5d32()
	Splus = Float32(Float32(S5s+S1s)+S4s)
	Sminus = Float32(S3s+S2s)
	S = Float32(Splus+Sminus)
    return S
end
function zad5d64()
	Splus = Float64(Float64(S5d+S1d)+S4d)
	Sminus = Float64(S3d+S2d)
	S = Float64(Splus+Sminus)
    return S
end
function zad5d()
	println("Algorytm D: \n pojedyncza precyzja: S = ", zad5d32())
	println(" podwójna precyzja: S = ", zad5d64())
end

#Rozwiązanie

function zad5()
	println("Dokładny wynik: S = -1.00657107000000e-11")
	zad5a()
	zad5b()
	zad5c()
	zad5d()
end

zad5()
