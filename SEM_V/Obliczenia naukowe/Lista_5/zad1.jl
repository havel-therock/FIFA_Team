#=
#   @author Mateusz Laskowski
=#
################# SOLUTION FOR TASK 1 #################

include("module.jl")

using gaussian

function solutionGaussianElimination()
    Matrix, _n, l = gaussian.readMatrix("dane/input/A.txt")
    println(_n)
    print(Matrix)
    # ciąg dalszy nastąpi
end

solutionGaussianElimination()