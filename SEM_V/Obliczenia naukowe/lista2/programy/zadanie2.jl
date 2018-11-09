#author: Jan Sieradzki
#nr_indeksu: 236441

using Plots

# Prepering ln
function ln(x)
  return log(exp(1), x)
end

# Prepering function
function f(x)
  return (exp(1)^x) * ln(1 + exp(-x))
end

# Showing results
function exc2()
	for i=0:60
		println(f(i))
	end
end

n =0:60
y=[f(z) for z=n]
plot(n,y, label="y=f(x)")

png("plotByJulia")

exc2()
