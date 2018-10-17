#@author: Piotr Klepczyk

#wyznaczanie epsilonu maszynowego
println("epsilon maszynowy:")
#Float16
 e=Float16(0)
 one=Float16(1)
 x=Float16(1)
 
 while Float16(one+x)>one
	e=x
	x=Float16(x/2)
 end
 println("Float16:")
 println(e)
 println(eps(Float16))
#Float32
 e=Float32(0)
 one=Float32(1)
 x=Float32(1)
 
 while Float32(one+x)>one
	e=x
	x=Float32(x/2)
 end
 println("Float32:")
 println(e)
 println(eps(Float32))
#Float64
 e=Float64(0)
 one=Float64(1)
 x=Float64(1)
 
 while Float64(one+x)>one
	e=x
	x=Float64(x/2)
 end
 println("Float64:")
 println(e)
 println(eps(Float64))

#wyznaczanie liczby eta
println()
println("liczenia liczby eta:")
#Float16
 x=Float16(1)
 y=Float16(x/2)
 
 while x>0 && y>0 && x!=y
	x=y
	y=Float16(x/2)
 end
 println("Float16:")
 println(x)
 println(nextfloat(Float16(0.0)))
#Float32
 x=Float32(1)
 y=Float32(x/2)
 
 while x>0 && y>0 && x!=y
	x=y
	y=Float32(x/2)
 end
 println("Float32:")
 println(x)
 println(nextfloat(Float32(0.0)))
 #Float64
 x=Float64(1)
 y=Float64(x/2)
 
 while x>0 && y>0 && x!=y
	x=y
	y=Float64(x/2)
 end
 println("Float64:")
 println(x)
 println(nextfloat(Float64(0.0)))
 
#wyznaczanie max
 println()
 println("wyznaczanie max")
#Float16
 x=Float16(1)
 M=Float16(2-Float16(2.0^Float16(-1*Float16(10-1))))
 E=Float16(Float16(2^Float16(5-1))-1)
 x=Float16(M*Float16(2^E))
 
 println("Float16:")
 println(x)
 println(realmax(Float16))
#Float32
 x=Float32(1)
 M=Float32(2-Float32(2.0^Float32(-1*Float32(23-1))))
 E=Float32(Float32(2^Float32(8-1))-1)
 x=Float32(M*Float32(2^E))
 
 println("Float32:")
 println(x)
 println(realmax(Float32))
#Float64
 x=Float64(1)
 M=Float64(2-Float64(2.0^Float64(-1*Float64(52-1))))
 E=Float64(Float64(2^Float64(11-1))-1)
 x=Float64(M*Float64(2^E))
 
 println("Float64:")
 println(x)
 println(realmax(Float64))