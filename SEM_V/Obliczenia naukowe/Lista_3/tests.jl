#=
#   @author Mateusz Laskowski
=#
################# TESTS TO ZAD1/ZAD2/ZAD3 #################
include("zad1.jl")

using calculationMethods
using Base.Test

function f1(x)
    return 3x^7
end
function f2(x) 
    return log(complex(x))
end
function pf1(x)
    return 21x^6
end
function pf2(x)
    return 1/x
end

EPSILON = 0.00001
DELTA = 0.00001

## uncomment one of the tests to see the results

# @test mbisekcji(f1, -3.0, 1.5, DELTA, EPSILON)
# @test mbisekcji(f1, -3.0, 20.0, DELTA, EPSILON)
# @test mbisekcji(f1, 1.0, 1.5, DELTA, EPSILON)                              ## return error = 1
# @test mbisekcji(f1, 0.5, 2.5, DELTA, EPSILON)                              ## return error = 1

# @test mstycznych(f1, pf1, -3.0, DELTA, EPSILON, 1000)                       
# @test mstycznych(f1, pf2, 20.0, DELTA, EPSILON, 1000)                     ## return error = 2                       


# @test mbisekcji(f2, -3.0, 1.5, DELTA, EPSILON)
# @test mbisekcji(f2, 1.0, 1.5, DELTA, EPSILON)               
# @test mbisekcji(f2, 0.5, 150.0, DELTA, EPSILON)

# @test mstycznych(f2, pf2, -3.0, DELTA, EPSILON, 1000)                       ## return error = 2        
# @test mstycznych(f2, pf2, 20.0, DELTA, EPSILON, 1000)                       ## return error = 2

# @test msiecznych(f1, 0.5, 1.5, DELTA, EPSILON, 1000)
# @test msiecznych(f1, 0.5, 20.0, DELTA, EPSILON, 1000)
# @test msiecznych(f2, 0.8, 1.2, DELTA, EPSILON, 1000)


## below are the results of all examples

println(calculationMethods.mbisekcji(f1, -3.0, 1.5, DELTA, EPSILON))
println(calculationMethods.mbisekcji(f1, -3.0, 20.0, DELTA, EPSILON))
println(calculationMethods.mbisekcji(f1, 1.0, 1.5, DELTA, EPSILON))                              ## return error = 1
println(calculationMethods.mbisekcji(f1, 0.5, 2.5, DELTA, EPSILON))                              ## return error = 1

println(calculationMethods.mstycznych(f1, pf1, -3.0, DELTA, EPSILON, 1000))                       
println(calculationMethods.mstycznych(f1, pf2, 20.0, DELTA, EPSILON, 1000))                     ## return error = 2                       

println(calculationMethods.mbisekcji(f2, -3.0, 1.5, DELTA, EPSILON))
println(calculationMethods.mbisekcji(f2, 1.0, 1.5, DELTA, EPSILON))               
println(calculationMethods.mbisekcji(f2, 0.5, 150.0, DELTA, EPSILON))

println(calculationMethods.mstycznych(f2, pf2, -3.0, DELTA, EPSILON, 1000))                       ## return error = 2        
println(calculationMethods.mstycznych(f2, pf2, 20.0, DELTA, EPSILON, 1000))                       ## return error = 2

println(calculationMethods.msiecznych(f1, 0.5, 1.5, DELTA, EPSILON, 1000))
println(calculationMethods.msiecznych(f1, 0.5, 20.0, DELTA, EPSILON, 1000))
println(calculationMethods.msiecznych(f2, 0.8, 1.2, DELTA, EPSILON, 1000))
