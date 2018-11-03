#=
#   @author Mateusz Laskowski
=#

################# EXPERIMENTS #################

function calculate(x_val, c_val)
# Function calculate 40 iterations
    result = Float64[];
    x::Float64 = x_val;
    c::Float64 = c_val;
    for i in 1:40
        x = x^2 + c;
        push!(result, x);
    end
    return result;
end

E1 = calculate(1, -2);                  # 1. experiment
E2 = calculate(2, -2);                  # 2. experiment
E3 = calculate(1.99999999999999, -2);   # 3. experiment
E4 = calculate(1, -1);                  # 4. experiment
E5 = calculate(-1, -1);                 # 5. experiment
E6 = calculate(0.75, -1);               # 6. experiment
E7 = calculate(0.25, -1);               # 7. experiment

println("Experiment nr 1");
for i in [1, 2, 3, 4, 5, 10, 15, 20, 25, 30, 35, 36, 37, 38, 39, 40]
    #@printf("%d -> %.15f\n", i, E1[i]);
    @printf("%.15f\n", E1[i]);
end

println("Experiment nr 2");
for i in [1, 2, 3, 4, 5, 10, 15, 20, 25, 30, 35, 36, 37, 38, 39, 40]
    #@printf("%d -> %.15f\n", i, E2[i]);
    @printf("%.15f\n", E2[i]);
end

println("Experiment nr 3");
for i in [1, 2, 3, 4, 5, 10, 15, 20, 25, 30, 35, 36, 37, 38, 39, 40]
    #@printf("%d -> %.15f\n", i, E3[i]);
    @printf("%.15f\n", E3[i]);
end

println("Experiment nr 4");
for i in [1, 2, 3, 4, 5, 10, 15, 20, 25, 30, 35, 36, 37, 38, 39, 40]
    #@printf("%d -> %.15f\n", i, E4[i]);
    @printf("%.15f\n", E4[i]);
end

println("Experiment nr 5");
for i in [1, 2, 3, 4, 5, 10, 15, 20, 25, 30, 35, 36, 37, 38, 39, 40]
    #@printf("%d -> %.15f\n", i, E5[i]);
    @printf("%.15f\n", E5[i]);
end

println("Experiment nr 6");
for i in [1, 2, 3, 4, 5, 10, 15, 20, 25, 30, 35, 36, 37, 38, 39, 40]
    #@printf("%d -> %.15f\n", i, E6[i]);
    @printf("%.15f\n", E6[i]);
end

println("Experiment nr 7");
for i in [1, 2, 3, 4, 5, 10, 15, 20, 25, 30, 35, 36, 37, 38, 39, 40]
    #@printf("%d -> %.15f\n", i, E7[i]);
    @printf("%.15f\n", E7[i]);
end