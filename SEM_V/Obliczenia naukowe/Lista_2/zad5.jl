#=
#   @author Mateusz Laskowski
=#

################# ITERATIONS #################

function calculate(p_val, r_val, A)
# Function calculate 40 iterations
    result = A[];
    p::A = p_val;
    r::A = r_val;
    for i in 1:40
        p = p + r * p * (1 - p);
        push!(result, p);
    end
    return result;
end

function calculateWithReduce(p_val, r_val, A)
# Function calculate 40 iterations with reduce in the 10-th step
result = A[];
p::A = p_val;
r::A = r_val;
for i in 1:40
    p = p + r * p * (1 - p);
    if(i == 10)
        p = 0.722;
    end
    push!(result, p);
end
return result;
end

R32 = calculate(0.01, 3.0, Float32);
R64 = calculate(0.01, 3.0, Float64);
RR32 = calculateWithReduce(0.01, 3.0, Float32);

println("A)");
println("Float32");
for i in 1:40 
    @printf("%d -> %.15f\n", i, R32[i]);
    #@printf("%.15f\n", R32[i]);
end

println("Float32 REDUCE");
for i in 1:40 
    @printf("%d -> %.15f\n", i, RR32[i]);
    #@printf("%.15f\n", RR32[i]);
end

println("B)");
println("Float32");
for i in [1,2,3,4,5,10,15,20,25,30,35,36,37,38,39,40] 
    #@printf("%d -> %.15f\n", i, R32[i]);
    @printf("%.15f\n", R32[i]);
end

println("Float64");
for i in [1,2,3,4,5,10,15,20,25,30,35,36,37,38,39,40] 
    #@printf("%d -> %.15f\n", i, R64[i]);
    @printf("%.15f\n", R64[i]);
end




