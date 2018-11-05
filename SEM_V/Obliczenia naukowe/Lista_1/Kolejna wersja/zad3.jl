#!/usr/bin/env julia

#@author: Niebieski Kapturek, INF-FIFA-PPT-TEAM®
#@title: zad3

function zad3()

# Zmienna delta oznacza krok ð=2^-52

delta = 2.0^-52

# Podpunkt A -> [1,2]

println("Podpunkt A -> [1,2]\n")

# Sprawdzenie reprezentacji bitowej liczby 1.0
println("bits(1.0)=",bits(1.0))

# Sprawdzenie reprezentacji bitowej liczb: 1.0+ð oraz następnej po 1.0
println("bits(1.0+ð)=",bits(1.0))
println("bits(nextfloat(Float64(1.0)))=",bits(nextfloat(Float64(1.0))))
println("Reprezentacja bitowa liczb: 1.0+ð oraz następnej liczby po 1.0 jest taka sama")

# Sprawdzenie reprezentacji bitowej liczby 1.0+2ð
println("bits(1.0+2ð)=",bits(1.0 + 2*delta))

# Sprawdzenie reprezentacji bitowej liczb: 2.0-ð oraz 1.0+ð(2^52-1)
println("bits(2.0-ð)=",bits(2.0 - delta))
println("bits(1.0+((2.0^52)-1.0)*ð)=",bits(1.0+((2.0^52)-1.0)*delta))
println("Reprezentacja bitowa liczb: 2.0-ð oraz 1.0+ð(2^52-1) jest taka sama")

# Sprawdzenie reprezentacji bitowej liczby 2.0
println("bits(2.0)=",bits(2.0))

# Wniosek
println("Krok ð=2^-52 w przedziale [1,2] przesuwa o bit")

# Podpunkt B -> [0.5,1]

println("\nPodpunkt B -> [0.5,1]\n")

# Sprawdzenie reprezentacji bitowej liczby 0.5
println("bits(0.5)=",bits(0.5))

# Sprawdzenie reprezentacji bitowej liczb: następnej po 0.5, 0.5+ð oraz 0.5+0.5ð
println("bits(nextfloat(Float64(0.5)))=",bits(nextfloat(Float64(1.0))))
println("bits(0.5+ð)=",bits(0.5+delta))
println("bits(0.5+0.5ð)=",bits(0.5+0.5*delta))
println("Reprezentacja bitowa liczb: 0.5+0.5ð oraz następnej po 0.5 jest taka sama")

# Wniosek
println("Krok ð=2^-52 w przedziale [0.5,1] przesuwa o 2 bity")

# Podpunkt C -> [2,4]

println("\nPodpunkt C -> [2,4]\n")

# Reprezentacja bitowa liczby 4.0
println("bits(4.0)=",bits(4.0))

# Reprezentacja bitowa liczb: następnej po 2.0, 2.0+ð oraz 2.0+2ð
println("bits(nextfloat(Float64(2.0)))=",bits(nextfloat(Float64(2.0))))
println("bits(2.0+ð)=",bits(2.0+delta))
println("bits(2.0+2ð)=",bits(2.0+2*delta))
println("Reprezentacja bitowa liczb: 2.0+2ð oraz następnej po 2.0 jest taka sama")

# Wniosek
println("Dwa kroki ð=2^-52 w przedziale [2,4] przesuwają o bit")
end

zad3()
