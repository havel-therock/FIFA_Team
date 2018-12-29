#=
#   @author Mateusz Laskowski
=#
################# SOLUTION FOR TASK 1 #################

include("module.jl")

using gaussian
using Base.Test

function solutionGaussianElimination()
    Matrix, _n, l = gaussian.readMatrix("dane/input/A.txt")
    V, n = gaussian.readVector("dane/input/b.txt")
    x, error = gaussian.gaussianElimination(Matrix, V, n, l)
    println("gaussianElimination: \n\terror -> ", error)
    gaussian.writeVector(x, "dane/output/vector.txt")

    x, error = gaussian.gaussianEliminationWithPivot(Matrix, V, n, l)
    println("gaussianEliminationWithPivot: \n\terror -> ", error)
    gaussian.writeVector(x, "dane/output/vectorWithPivot.txt")
end

function solutionDistributionLU()
    test = true
    Matrix, n, l = gaussian.readMatrix("dane/input/A.txt")
    (L, U), error = gaussian.distributionLU(Matrix, n, l)
    println("distributionLU: \n\terror -> ", error)
    distributionMatrix = L * U

    # test distributionMatrix
    if(test)
        for i in 1:n
            for j in 1:n
                # @test Matrix[i, j] ≈ distributionMatrix[i, j]
                println("i = ", i, " j = ", j)
                print(Matrix[i, j], "\t")
                println(distributionMatrix[i, j])
            end
        end
    end
            
    Matrix, n, l = gaussian.readMatrix("dane/input/A.txt")
    (L, U), error = gaussian.distributionLUWithPivot(Matrix, n, l)
    println("distributionLUWithPivot: \n\terror -> ", error)
    distributionMatrixWithPivot = L * U

    # test distributionMatrixWithPivot
    if(test)
        for i in 1:n
            for j in 1:n
                # @test Matrix[i, j] ≈ distributionMatrixWithPivot[i, j]
                println("i = ", i, " j = ", j)
                print(Matrix[i, j], "\t")
                println(distributionMatrixWithPivot[i, j])
            end
        end
    end
end

function solutionFromLUMatrices()
    Matrix, _n, l = gaussian.readMatrix("dane/input/A.txt")
    V, n = gaussian.readVector("dane/input/b.txt")
    (L, U), error = gaussian.distributionLU(Matrix, n, l)
    x = gaussian.solutionFromLUMatrices(L, U, V, n, l)
    gaussian.writeVector(x, "dane/output/vectorFromLU.txt")
end

#=
#   call all functions
=#
# First tast
solutionGaussianElimination() 
# Second task
solutionDistributionLU()
# Third task
solutionFromLUMatrices()