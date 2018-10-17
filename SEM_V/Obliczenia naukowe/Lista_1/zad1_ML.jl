#=
#   @author Mateusz Laskowski
=#

################# EPSILON MASZYNOWY #################
println("[1] - Program wyznaczający iteracyjnie epsilony maszynowe");
println();

# Dla Float16
print("F Float16 -> ");
println(eps(Float16));

epsilon = 0;                                                # zmienna przechowująca epsilon maszynowy
matcheps = Float16(1.0);                                    # zmienna przechowująca najmniejszy matcheps > 0 (proponowany w zad matcheps = 1.0)
while Float16(1.0 + matcheps) > Float16(1.0)
    epsilon = matcheps;
    matcheps = Float16(matcheps / 2);
end

print("I Float16 -> ");
println(epsilon);

# Dla Float32
print("F Float32 -> ");
println(eps(Float32));

epsilon = 0;                                                # zmienna przechowująca epsilon maszynowy
matcheps = Float32(1.0);                                    # zmienna przechowująca najmniejszy matcheps > 0 (proponowany w zad matcheps = 1.0)
while Float32(1.0 + matcheps) > Float32(1.0)
    epsilon = matcheps;
    matcheps = Float32(matcheps / 2);
end

print("I Float32 -> ");
println(epsilon);

# Dla Float64
print("F Float64 -> ");
println(eps(Float64));

epsilon = 0;                                                # zmienna przechowująca epsilon maszynowy
matcheps = Float64(1.0);                                    # zmienna przechowująca najmniejszy matcheps > 0 (proponowany w zad matcheps = 1.0)
while Float64(1.0 + matcheps) > Float64(1.0)
    epsilon = matcheps;
    matcheps = Float64(matcheps / 2);
end

print("I Float64 -> ");
println(epsilon);
println("float.h\nFLT_EPSILON 1.19209290e-07F\nDBL_EPSILON 2.2204460492503131e-16\nLDBL_EPSILON 1.084202172485504434007452e-19L");
println();

################# LICZBA ETA #################
println("[2] - Program wyznaczający iteracyjnie liczbę eta");
println();

# Dla Float16
print("F Float16 -> ");
println(nextfloat(Float16(0.0)));

eta = Float16(1.0);                                         # zmienna przechowująca liczbę eta
temp = Float16(eta / 2);                                    # zmienna przechowująca liczbę eta/2 (tymczasowa, do obliczeń)
while (Float16(temp) > Float16(0.0))
    eta = temp;                                             
    temp = Float16(temp / 2);                              
end

print("I Float16 -> ");
println(eta);

# Dla Float32
print("F Float32 -> ");
println(nextfloat(Float32(0.0)));

eta = Float32(1.0);                                         # zmienna przechowująca liczbę eta
temp = Float32(eta / 2);                                    # zmienna przechowująca liczbę eta/2 (tymczasowa, do obliczeń)
while (Float32(temp) > Float32(0.0))
    eta = temp;                                             
    temp = Float32(temp / 2);                              
end

print("I Float32 -> ");
println(eta);

# Dla Float64
print("F Float64 -> ");
println(nextfloat(Float64(0.0)));

eta = Float64(1.0);                                         # zmienna przechowująca liczbę eta
temp = Float64(eta / 2);                                    # zmienna przechowująca liczbę eta/2 (tymczasowa, do obliczeń)
while (Float64(temp) > Float64(0.0))
    eta = temp;                                             
    temp = Float64(temp / 2);                              
end

print("I Float64 -> ");
println(eta);

println();

################# LICZBA (MAX) #################
println("[3] - Program wyznaczający iteracyjnie liczbę (MAX)");

# Dla Float16
print("F Float16 -> ");
println(realmax(Float16));

max = Float16(2.0);
while (isinf(Float16(max)) == false)                        # dopuki zmienna max nie jest infinity wykonuj
    if (isinf(Float16(max * 2.0)) == false)                 # jeżeli prawda to znaczy że następne pomnożenie max*2 wyjdzie poza pamięć i przerywamy z aktualnym maxem
        max = Float16(max * 2);
    else
        break
    end
end

temp = Float16(max / 2)                                     
while (isinf(Float16(max)) == false)                        # dopuki zmienna max nie jest infinity wykonuj
    if (isinf(Float16(max + temp)) == false)                # jeżeli prawda to znaczy że następne dodanie max+temp wyjdzie poza pamięć, więc przerywamy z aktualnym maxem
        max = Float16(max + temp);
        temp = Float16(temp / 2);
    else
        break
    end
end

print("I Float16 -> ");
println(max);

# Dla Float32
print("F Float32 -> ");
println(realmax(Float32));

max = Float32(2.0);
while (isinf(Float32(max)) == false)                        # dopuki zmienna max nie jest infinity wykonuj
    if (isinf(Float32(max * 2.0)) == false)                 # jeżeli prawda to znaczy że następne pomnożenie max*2 wyjdzie poza pamięć i przerywamy z aktualnym maxem
        max = Float32(max * 2);
    else
        break
    end
end

temp = Float32(max / 2)                                     
while (isinf(Float32(max)) == false)                        # dopuki zmienna max nie jest infinity wykonuj
    if (isinf(Float32(max + temp)) == false)
        max = Float32(max + temp);
        temp = Float32(temp / 2);
    else                                                    # jeżeli prawda to znaczy że następne dodanie max+temp wyjdzie poza pamięć, więc przerywamy z aktualnym maxem
        break
    end
end

print("I Float32 -> ");
println(max);

# Dla Float64
print("F Float64 -> ");
println(realmax(Float64));

max = Float64(2.0);
while (isinf(Float64(max)) == false)                        # dopuki zmienna max nie jest infinity wykonuj
    if (isinf(Float64(max * 2.0)) == false)                 # jeżeli prawda to znaczy że następne pomnożenie max*2 wyjdzie poza pamięć i przerywamy z aktualnym maxem
        max = Float64(max * 2);
    else
        break
    end
end

temp = Float64(max / 2)                                     
while (isinf(Float64(max)) == false)                        # dopuki zmienna max nie jest infinity wykonuj
    if (isinf(Float64(max + temp)) == false)                # jeżeli prawda to znaczy że następne dodanie max+temp wyjdzie poza pamięć, więc przerywamy z aktualnym maxem
        max = Float64(max + temp);
        temp = Float64(temp / 2);
    else         
        break
    end
end

print("I Float64 -> ");
println(max);


println("float.h\nFLT_MAX 3.402823e+38\nDBL_MAX 1.797693e+308\nLDBL_MAX 1.189731e+4932");


