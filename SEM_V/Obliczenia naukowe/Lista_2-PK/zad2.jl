#@author: Piotr Klepczyk

using Plots

function ln(x)
 return log(exp(1), x)
end

function f(x)
	return (exp(1)^x)*(ln(1+(exp(1)^(-x))))
end

plot([f(x) for x = linspace(0,45,500)])

png("plot_jl");