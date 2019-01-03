#@author Piotr Klepczyk

include("blocksys.jl")
using blocksys

#zad1
println("ZAD1:")
#####################################################################################################
println("Dla 16:")
#bez wyboru dla 16
println("bez wyboru:")
blocksys.fzad1("A.txt","b.txt",false,false,false)
#z wyborem
println("z wyborem:")
blocksys.fzad1("A.txt","b.txt",true,false,false)

println("Dla 10000:")
#bez wyboru
println("bez wyboru:")
blocksys.fzad1("10kA.txt","10kb.txt",false,false,false)
#z wyborem
println("z wyborem:")
blocksys.fzad1("10kA.txt","10kb.txt",true,false,false)

println("Dla 50000:")
#bez wyboru
println("bez wyboru:")
blocksys.fzad1("50kA.txt","50kb.txt",false,false,false)
#z wyborem
println("z wyborem:")
blocksys.fzad1("50kA.txt","50kb.txt",true,false,false)

#zad2
println("ZAD2:")
#######################################################################################################
#=println("Dla 16:")
#bez wyboru
println("bez wyboru:")
LU,A = blocksys.fzad1("A.txt","b.txt",false,true,false)
L,U = blocksys.separate(LU,16)
e = Int64(0)
M = L*U
for i in 1:16
    for j in 1:16
        if M[i,j]≈A[i,j]
            
        else
            e = e + 1    
        end
    end
end
if e==0
    println("A = LU")
    blocksys.fzad1("A.txt","b.txt",false,true,true)
else
    println("A != LU")
end
#z wyborem
println("z wyborem:")
LU,A = blocksys.fzad1("A.txt","b.txt",true,true,false)
L,U = blocksys.separate(LU,16)
e = Int64(0)
M = L*U
for i in 1:16
    for j in 1:16
        if M[i,j]≈A[i,j]
            
        else
            e = e + 1    
        end
    end
end
if e==0
    println("A = LU")
    blocksys.fzad1("A.txt","b.txt",true,true,true)
else
    println("A != LU")
end

println("Dla 10000:")
#bez wyboru
println("bez wyboru:")
LU,A = blocksys.fzad1("10kA.txt","10kb.txt",false,true,false)
L,U = blocksys.separate(LU,10000)
e = Int64(0)
M = L*U
for i in 1:10000
    for j in 1:10000
        if M[i,j]≈A[i,j]
            
        else
            e = e + 1    
        end
    end
end
if e==0
    println("A = LU")
    blocksys.fzad1("10kA.txt","10kb.txt",false,true,true)
else
    println("A != LU")
end
#z wyborem
println("z wyborem:")
LU,A = blocksys.fzad1("10kA.txt","10kb.txt",true,true,false)
L,U = blocksys.separate(LU,10000)
e = Int64(0)
M = L*U
for i in 1:10000
    for j in 1:10000
        if M[i,j]≈A[i,j]
            
        else
            e = e + 1    
        end
    end
end
if e==0
    println("A = LU")
    blocksys.fzad1("10kA.txt","10kb.txt",true,true,true)
else
    println("A != LU")
end

println("Dla 50000:")
#bez wyboru
println("bez wyboru:")
LU,A = blocksys.fzad1("50kA.txt","50kb.txt",false,true,false)
L,U = blocksys.separate(LU,50000)
e = Int64(0)
M = L*U
for i in 1:50000
    for j in 1:50000
        if M[i,j]≈A[i,j]
            
        else
            e = e + 1    
        end
    end
end
if e==0
    println("A = LU")
    blocksys.fzad1("50kA.txt","50kb.txt",false,true,true)
else
    println("A != LU")
end
#z wyborem
println("z wyborem:")
LU,A = blocksys.fzad1("50kA.txt","50kb.txt",true,true,false)
L,U = blocksys.separate(LU,50000)
e = Int64(0)
M = L*U
for i in 1:50000
    for j in 1:50000
        if M[i,j]≈A[i,j]
            
        else
            e = e + 1    
        end
    end
end
if e==0
    println("A = LU")
    blocksys.fzad1("50kA.txt","50kb.txt",true,true,true)
else
    println("A != LU")
end=#

#zad3
println("ZAD3:")
######################################################################################################
println("Dla 16:")
#bez wyboru dla 16
println("bez wyboru:")
blocksys.fzad1("A.txt","b.txt",false,true,true)
#z wyborem
println("z wyborem:")
blocksys.fzad1("A.txt","b.txt",true,true,true)

println("Dla 10000:")
#bez wyboru
println("bez wyboru:")
blocksys.fzad1("10kA.txt","10kb.txt",false,true,true)
#z wyborem
println("z wyborem:")
blocksys.fzad1("10kA.txt","10kb.txt",true,true,true)

println("Dla 50000:")
#bez wyboru
println("bez wyboru:")
blocksys.fzad1("50kA.txt","50kb.txt",false,true,true)
#z wyborem
println("z wyborem:")
blocksys.fzad1("50kA.txt","50kb.txt",true,true,true)