#=
#   @author Mateusz Laskowski
=#

################# DRAW PLOT OF THE FUNCTION #################

using Plots;

in = linspace(0, 40, 250);

function ln(x)
  return log(exp(1), x);
end

function f(x)
  return (exp(1)^x) * ln(1 + exp(-x));
end

arr = [f(x) for x = in];

plot(arr);

png("juliaplot");