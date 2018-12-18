#=
#   @author Mateusz Laskowski
=#
################# SOLUTION FOR TASK 1 #################

include("module.jl")

using gaussian

function solutionGaussianElimination()
    Matrix, _n, l = gaussian.readMatrix("dane/input/A.txt")
    V, n = gaussian.readVector("dane/input/b.txt")
    x, error = gaussian.gaussianElimination(Matrix, V, n, l)

    gaussian.writeVector(x, "dane/output/vector.txt")

    x, error = gaussian.gaussianEliminationWithPivot(Matrix, V, n, l)

    gaussian.writeVector(x, "dane/output/vectorWithPivot.txt")
end

solutionGaussianElimination() 