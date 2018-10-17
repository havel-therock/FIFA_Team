#@author: Piotr Klepczyk

#Float16
e=Float16(Float16(3*Float16(Float16(4/3)-1))-1)
println("Float16:")
println(e)
println(eps(Float16))

#Float32
e=Float32(Float32(3*Float32(Float32(4/3)-1))-1)
println("Float32:")
println(e)
println(eps(Float32))

#Float64
e=Float64(Float64(3*Float64(Float64(4/3)-1))-1)
println("Float64:")
println(e)
println(eps(Float64))