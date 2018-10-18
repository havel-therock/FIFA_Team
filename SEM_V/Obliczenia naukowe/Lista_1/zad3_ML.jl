#=
#   @author Mateusz Laskowski
=#

################# ROZMIESZCZENIE W PRZEDZIALE [p1,p2] #################
# Przedział [1,2]
p1 = Float64(1.0);
p2 = Float64(2.0);
delta = Float64(nextfloat(p1) - Float64(p1));
println("DELTA = ", delta);
k = Float64(1.0);                                                   # zmienna, która będzie miała wartości 1,2,...,(2^52)-1
x = Float64(1.0);                                                   # zmienna przechowująca liczbę zmiennopozycyjną
while (Float64(x) <= Float64(p2))                                   # dopuki x jest w przedziale [1,2]
    x = Float64(x + k * delta);
    if x - prevfloat(x) != delta
        println("x = ", x, " => DELTA = ", x - prevfloat(x));
    end
    k = Float64(k + 1.0);
end

# Przedział [0.5,1]
p1 = Float64(0.5);
p2 = Float64(1.0);
delta = Float64(nextfloat(p1) - Float64(p1));
println("DELTA = ", delta);
k = Float64(1.0);                                                   # zmienna, która będzie miała wartości 1,2,...,(2^52)-1
x = Float64(0.5);                                                   # zmienna przechowująca liczbę zmiennopozycyjną
while (Float64(x) <= Float64(p2))                                   # dopuki x jest w przedziale [1,2]
    x = Float64(x + k * delta);
    if x - prevfloat(x) != delta
        println("x = ", x, " => DELTA = ", x - prevfloat(x));
    end
    k = Float64(k + 1.0);
end

# Przedział [2,4]
p1 = Float64(2.0);
p2 = Float64(4.0);
delta = Float64(nextfloat(p1) - Float64(p1));
println("DELTA = ", delta);
k = Float64(1.0);                                                   # zmienna, która będzie miała wartości 1,2,...,(2^52)-1
x = Float64(2.0);                                                   # zmienna przechowująca liczbę zmiennopozycyjną
while (Float64(x) <= Float64(p2))                                   # dopuki x jest w przedziale [1,2]
    x = Float64(x + k * delta);
    if x - prevfloat(x) != delta
        println("x = ", x, " => DELTA = ", x - prevfloat(x));
    end
    k = Float64(k + 1.0);
end

# Wyniki bo długo zajmują obliczenia
# DELTA = 2.220446049250313e-16
# x = 2.000000018455019 => DELTA' = 4.440892098500626e-16
# DELTA = 1.1102230246251565e-16
# x = 1.0000000092275094 => DELTA' = 2.220446049250313e-16
# DELTA = 4.440892098500626e-16
# x = 4.000000036910038 => DELTA' = 8.881784197001252e-16
#
# WNIOSEK: Coraz większę odległości między deltami o dokładnie 2^1 większe, 
# czyli im dalej tym zwiększa się rozrzedzenie liczb Float64