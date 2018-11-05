#!/usr/bin/env julia

#@author: Niebieski Kapturek, INF-FIFA-PPT-TEAM®
#@title: zad1

# podpunkt a) "macheps"

# funkcja rekurencyjna, wyliczająca epsilon maszynowy w Float16

function macheps16(x)
	macheps = x/2
	if 1 + macheps > 1
	        macheps16(Float16(macheps))
	else
		return x
	end
end

# funkcja rekurencyjna, wyliczająca epsilon maszynowy w Float32

function macheps32(x)
	macheps = x/2
	if 1 + macheps>1
	        macheps32(Float32(macheps))
	else
	        return x
	end
end

# funkcja rekurencyjna, wyliczająca epsilon maszynowy w Float64

function macheps64(x)
	macheps = x/2
	if 1 + macheps > 1
	        macheps64(Float64(macheps))
	else
	        return x
	end
end

# funkcja, pokazująca wyniki podpunku a)

function zad1a()
	println("eps(Float16)=",eps(Float16),", macheps16()=",macheps16(1))
	println("eps(Float32)=",eps(Float32),", macheps32()=",macheps32(1))
	println("eps(Float64)=",eps(Float64),", macheps64()=",macheps64(1))
end

# podpunkt b) "eta"

# funkcja rekurencyjna, wyliczająca liczbę eta w Float16

function eta16(x)
	eta = x/2
	if eta > 0
        eta16(Float16(eta))
    else
        return x
    end
end

# funkcja rekurencyjna, wyliczająca liczbę eta w Float32

function eta32(x)
	eta = x/2
	if eta > 0
        eta32(Float32(eta))
    else
        return x
    end
end

# funkcja rekurencyjna, wyliczająca liczbę eta w Float64

function eta64(x)
	eta = x/2
	if eta > 0
        eta64(Float64(eta))
    else
        return x
    end
end

# funkcja, pokazująca wyniki podpunktu b)

function zad1b()
	println("nextfloat(Float16(0.0))=",nextfloat(Float16(0.0)), ", eta16()=",eta16(1))
	println("nextfloat(Float32(0.0))=",nextfloat(Float32(0.0)), ", eta32()=",eta32(1))
	println("nextfloat(Float64(0.0))=",nextfloat(Float64(0.0)), ", eta64()=",eta64(1))
end

# podpunkt c) "MAX"

# funkcja rekurencyjna, wyliczająca największą liczbę, będącą potęgą dwójki, mieszczącą się w arytmetyce Float16

function max16(x)
	max = x*2
	if !isinf(max)
        max16(Float16(max))
    else
        return x
    end
end

# funkcja rekurencyjna, wyliczająca największą liczbę, używa ona wyliczonej wyżej liczby i szuka najmniejszego i,
# takiego że x*(2-i) nie jest nieskończonością w arytmetyce Float16

function mymax16(x)
	i = eta16(1)
	while isinf(x*(2-i))
		i = i*2
    end
	return x*(2-i)
end

# funkcja rekurencyjna, wyliczająca największą liczbę, będącą potęgą dwójki, mieszczącą się w arytmetyce Float32

function max32(x)
	max = x*2
	if !isinf(max)
        max32(Float32(max))
    else
        return x - 1
    end
end

# funkcja rekurencyjna, wyliczająca największą liczbę, używa ona wyliczonej wyżej liczby i szuka najmniejszego i,
# takiego że x*(2-i) nie jest nieskończonością w arytmetyce Float32

function mymax32(x)
	i = eta32(1)
	while isinf(x*(2-i))
		i = i*2
    end
	return x*(2-i)
end

# funkcja rekurencyjna, wyliczająca największą liczbę, będącą potęgą dwójki, mieszczącą się w arytmetyce Float64

function max64(x)
	max = x*2
	if !isinf(max)
        max64(Float64(max))
    else
        return x - 1
    end
end

# funkcja rekurencyjna, wyliczająca największą liczbę, używa ona wyliczonej wyżej liczby i szuka najmniejszego i,
# takiego że x*(2-i) nie jest nieskończonością w arytmetyce Float64

function mymax64(x)
	i = eta64(1)
	while isinf(x*(2-i))
		i = i*2
    end
	return x*(2-i)
end

# funkcja, pokazująca wyniki podpunktu c)

function zad1c()
	println("realmax(Float16)=", realmax(Float16), ", mymax16()=", mymax16(max16(1)))
	println("realmax(Float32)=", realmax(Float32), ", mymax32()=", mymax32(max32(1)))
	println("realmax(Float64)=", realmax(Float64), ", mymax64()=", mymax64(max64(1)))
end

zad1a()
zad1b()
zad1c()
