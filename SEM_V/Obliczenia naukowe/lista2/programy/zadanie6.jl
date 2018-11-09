#author: Jan Sieradzki
#nr_indeksu: 236441

#Function that cauculate recurenction for 40 iterations in Float64
#c is constant, i is iterator, x is first value
function calculate(x,c,i)
	result=(Float64)((Float64)((Float64)(x)*((Float64)(x))) + (Float64)(c))
	if (i<41)
		println(i , "	" ,x)	
		calculate(result,c,i+1)
	end
end

calculate(1.0,-2,0)  
println("\n")             
calculate(2.0,-2,0)     
println("\n")              
calculate(1.99999999999999, -2,0)    
println("\n") 
calculate(1.0, -1,0)    
println("\n")              
calculate(-1.0, -1,0) 
println("\n")                
calculate(0.75, -1,0) 
println("\n")               
calculate(0.25, -1,0)             


