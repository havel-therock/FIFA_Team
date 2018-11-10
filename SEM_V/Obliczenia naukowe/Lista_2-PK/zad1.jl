#@author: Piotr Klepczyk

#=
array sorting function
@par tab-array
@par n-array length
=#
function insertsort(tab,n)
	for i in 2:n
		k=tab[i]
		j=i-1
		while j>0 && tab[j]>k
			tab[j+1]=tab[j]
			j=j-1
		end
		tab[j+1]=k
	end
end

x64=Float64[2.718281828, -3.141592654, 1.414213562, 0.577215664, 0.301029995]
y64=Float64[1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]
x32=Float32[2.718281828, -3.141592654, 1.414213562, 0.577215664, 0.301029995]
y32=Float32[1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]
z64=Array{Float64,1}(5)
for i in 1:5
	z64[i]=Float64(x64[i]*y64[i])
end
z32=Array{Float32,1}(5)
for i in 1:5
	z32[i]=Float32(x32[i]*y32[i])
end

#forward Float32
S=Float32(0.0)
for i in 1:5
	S=Float32(S+Float32(x32[i]*y32[i]))
end
println("Float32 w przod	",S)

#forward Float64
S=Float64(0.0)
for i in 1:5
	S=Float64(S+Float64(x64[i]*y64[i]))
end
println("Float64 w przod	",S)

#backwards Float32
S=Float32(0.0)
for i in 5:-1:1
	S=Float32(S+Float32(x32[i]*y32[i]))
end
println("Float32 w tyl	",S)

#backwards Float64
S=Float64(0.0)
for i in 5:-1:1
	S=Float64(S+Float64(x64[i]*y64[i]))
end
println("Float64 w tyl	",S)

#from the largest to the smallest Float32
insertsort(z32,5)
S=Float32(0.0)
S1=Float32(0.0) #minus
S2=Float32(0.0) #plus
for i in 5:-1:1
	if z32[i]>0
		S2=Float32(S2+z32[i])
	else
		S1=Float32(S1+z32[i])
	end
end
S=Float32(S1+S2)
println("malejaco Float32	",S)

#from the largest to the smallest Float64
insertsort(z64,5)
S=Float64(0.0)
S1=Float64(0.0) #minus
S2=Float64(0.0) #plus
for i in 5:-1:1
	if z64[i]>0
		S2=Float64(S2+z64[i])
	else
		S1=Float64(S1+z64[i])
	end
end
S=Float64(S1+S2)
println("malejaco Float64	",S)

#from the smallest to the largest Float32
insertsort(z32,5)
S=Float32(0.0)
S1=Float32(0.0) #minus
S2=Float32(0.0) #plus
for i in 1:5
	if z32[i]>0
		S2=Float32(S2+z32[i])
	else
		S1=Float32(S1+z32[i])
	end
end
S=Float32(S1+S2)
println("rosnaco Float32	",S)

#from the smallest to the largest Float64
insertsort(z64,5)
S=Float64(0.0)
S1=Float64(0.0) #minus
S2=Float64(0.0) #plus
for i in 1:5
	if z64[i]>0
		S2=Float64(S2+z64[i])
	else
		S1=Float64(S1+z64[i])
	end
end
S=Float64(S1+S2)
println("rosnaco Float64	",S)