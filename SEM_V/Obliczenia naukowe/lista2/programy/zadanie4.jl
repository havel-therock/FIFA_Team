#author: Jan Sieradzki
#nr_indeksu: 236441

# Polynomials A factors
pa=[1, -210.0, 20615.0,-1256850.0,
      53327946.0,-1672280820.0, 40171771630.0, -756111184500.0,          
      11310276995381.0, -135585182899530.0,
      1307535010540395.0,     -10142299865511450.0,
      63030812099294896.0,     -311333643161390640.0,
      1206647803780373360.0,     -3599979517947607200.0,
      8037811822645051776.0,      -12870931245150988800.0,
      13803759753640704000.0,      -8752948036761600000.0,
      2432902008176640000.0]

# Polynomials B factors
pb=[1, -210.0 - 2.0^-32, 20615.0,-1256850.0,
      53327946.0,-1672280820.0, 40171771630.0, -756111184500.0,          
      11310276995381.0, -135585182899530.0,
      1307535010540395.0,     -10142299865511450.0,
      63030812099294896.0,     -311333643161390640.0,
      1206647803780373360.0,     -3599979517947607200.0,
      8037811822645051776.0,      -12870931245150988800.0,
      13803759753640704000.0,      -8752948036761600000.0,
      2432902008176640000.0]



using Polynomials;

#function that finds polynomial in two forms and cauculate zeros of function
#function checks if results are accurate  
function exc4Algorithm(p)
	Px = Poly(reverse(p));
	px = poly([i for i in 1.0:20.0]);
	rootPx = reverse(roots(Px));
	println("Roots found by roots() ");
	for i in 1:20
	    println(rootPx[i]);
	end
	println("\nnumber	P(z) result");
	for i in 1:20
	    println(i, "	",abs(polyval(Px, rootPx[i])))
	end
	println("\nnumber	p(z) result");
	for i in 1:20
	    println(i, "	",abs(polyval(px, rootPx[i])))
	end
	println("\nnumber	z-k");
	for i in 1:20
	    println(i, "	",abs(i - rootPx[i]))
	end
end

#starting algorithm
println("task A");
exc4Algorithm(pa)
println("task B");
exc4Algorithm(pb)



