#@author: Piotr Klepczyk

using Polynomials

p=[1, -210.0, 20615.0,-1256850.0,
      53327946.0,-1672280820.0, 40171771630.0, -756111184500.0,          
      11310276995381.0, -135585182899530.0,
      1307535010540395.0,     -10142299865511450.0,
      63030812099294896.0,     -311333643161390640.0,
      1206647803780373360.0,     -3599979517947607200.0,
      8037811822645051776.0,      -12870931245150988800.0,
      13803759753640704000.0,      -8752948036761600000.0,
      2432902008176640000.0]


pb=[1, -210.0 - 2.0^(-23), 20615.0,-1256850.0,
      53327946.0,-1672280820.0, 40171771630.0, -756111184500.0,          
      11310276995381.0, -135585182899530.0,
      1307535010540395.0,     -10142299865511450.0,
      63030812099294896.0,     -311333643161390640.0,
      1206647803780373360.0,     -3599979517947607200.0,
      8037811822645051776.0,      -12870931245150988800.0,
      13803759753640704000.0,      -8752948036761600000.0,
      2432902008176640000.0]

function absolute_p(z,f)
    return Float64(abs(polyval(f,z)))
end


#a)
println("A:")
Px = Poly(reverse(p))
px = poly([x for x in 1.0:20.0])
#|P(z)|
z = (roots(Px))
z = reverse(z)
println("|P(z)|")
println("z:    ",z)
println("k          z[k]                |P(z(k))|")
for i in 1:20
    println(i,"     ",z[i],"        ",absolute_p(z[i],Px))
end
println()


#|p(z)|
println("|p(z)|")
println("z:    ",z)
println("k          z[k]                |p(z(k))|")
for i in 1:20
    println(i,"     ",z[i],"        ",absolute_p(z[i],px))
end
println()


#|z(k)-k|
println("|z(k)-k|")
println("z:    ",z)
println("k          z[k]                    |z(k)-k|")
for i in 1:20
    println(i,"     ",z[i],"        ",abs(Float64(z[i]-i)))
end
println()

#b)
println("B:")
Px = Poly(reverse(pb))
px = poly([x for x in 1.0:20.0])
#|P(z)|
z = (roots(Px))
z = reverse(z)
println("|P(z)|")
println("z:    ",z)
println("k          z[k]                |P(z(k))|")
for i in 1:20
    println(i,"     ",z[i],"        ",absolute_p(z[i],Px))
end
println()


#|p(z)|
println("|p(z)|")
println("z:    ",z)
println("k          z[k]                |p(z(k))|")
for i in 1:20
    println(i,"     ",z[i],"        ",absolute_p(z[i],px))
end
println()


#|z(k)-k|
println("|z(k)-k|")
println("z:    ",z)
println("k          z[k]                    |z(k)-k|")
for i in 1:20
    println(i,"     ",z[i],"        ",abs(z[i]-i))
end
println()