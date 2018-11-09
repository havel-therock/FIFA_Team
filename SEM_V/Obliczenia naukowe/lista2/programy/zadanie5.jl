#author: Jan Sieradzki
#nr_indeksu: 236441

#Function that cauculate recurenction for 40 iterations in Float32
#r is constant, i is iterator, x is first value
function calculate32(x,r,i)
	result=(Float32)(x+((Float32)(r*x)*((Float32)(1.0-x))))
	if (i<41)
		println(i , "	" ,x)	
		calculate32(result,r,i+1)
	end
end

#Function that cauculate recurenction for 40 iterations in Float64
#r is constant, i is iterator, x is first value
function calculate64(x,r,i)
	result=(Float64)(x+((Float64)(r*x)*((Float64)(1.0-x))))
	if (i<41)
		println(i , "	" ,x)	
		calculate64(result,r,i+1)
	end
end

calculate32(0.01,3.0,0)
print("\nMODIFY\n")
calculate32(0.722,3.0,10)
print("\nB) 32\n")
calculate32(0.01,3.0,0)
print("\nB) 64\n")
calculate64(0.01,3.0,0)

