#@author Piotr Klepczyk

include("inout.jl")
include("zad1.jl")
include("zad2.jl")
include("zad3.jl")

module blocksys
export fzad1

using inout
using zad1
using zad2
using zad3

#=
The function controls the operation of the program, starts the appropriate operations for the given parameters.
@par matrix - name of file where matrix is saved
@par vector - name of file where vector is saved
@par chose - variable says if we choose the main element
@par lu - the variable tells whether we are creating the LU distribution
@par lu_calc - the variable says whether x will be calculated for the LU distribution
=#
function fzad1(matrix::String,vector::String,chose::Bool,lu::Bool,lu_clac::Bool)
    A,n1,l = inout.inMatrix(matrix)
    if vector != ""
        b,n2 = inout.inVector(vector)
    else
        b = zad1.calcVector(A,n1,l)
        n2=n1
    end
    if n1==n2
        if !chose #without chose
            if lu
                if lu_clac
                    LU = zad2.distributionLU(A,b,n1,l)
                    @time x = zad3.calcResult(LU,b,n1,l)
                    inout.outVector("out"*matrix,x)
                    println("Relative Error:",errorCalculate(x,n1))
                else
                    A1 = copy(A)
                    @time LU = zad2.distributionLU(A,b,n1,l)
                    return LU, A1
                end
            else
                @time x = zad1.gaussElimination(A,b,n1,l)
                inout.outVector("out"*matrix,x)
                println("Relative Error:",errorCalculate(x,n1))
            end
        else #with chose
            if lu
                if lu_clac
                    LU,swaped = zad2.distributionLU_chosen(A,b,n1,l)
                    @time x = zad3.clacRecult_chosen(LU,b,n1,l,swaped)
                    inout.outVector("out"*matrix,x)
                    println("Relative Error:",errorCalculate(x,n1))
                else
                    A1 = copy(A)
                    @time LU,swaped = zad2.distributionLU_chosen(A,b,n1,l)
                    LU1 = spzeros(Float64,n1,n1)
                    A2 = spzeros(Float64,n1,n1)
                    for i in 1:n1
                        k = find(swaped,i)
                        for j in 1:n1
                            LU1[k,j] = LU[i,j]
                        end
                    end
                    for i in 1:n1
                        k = find(swaped,i)
                        for j in 1:n1
                            A2[k,j] = A1[i,j]
                        end
                    end
                    return LU1, A2
                end
            else
                @time x = zad1.gaussElimination_chosen(A,b,n1,l)
                inout.outVector("out"*matrix,x)
                println("Relative Error:",errorCalculate(x,n1))
            end
        end
    else
        println("Vector is wrong for matrix")
        return 0
    end
end

#=
The function finds an index in the swap table
@par swaped - swap table
@par x - searched index
=#
function find(swaped::Vector{Int64}, x::Int64)
    i = 1
    while x!=swaped[i]
        i = i + 1
    end
    return i
end

#=
The function has an average relative error
@par x - the results for the error will be calculated
@par n - number of results
=#
function errorCalculate(x::SparseVector, n::Int64)
    e = Float64(0.0)
    for i in 1:n
        e = e + abs(1-x[i])
    end
    return e/n
end

#=
The function displays the matrix in the terminal
@par X - matrix
@par n - size of matrix
=#
function show(X::SparseMatrixCSC,n::Int64)
    for i in 1:n
        for j in 1:n
            print(X[i,j],"|")
        end
        println()
    end
end

#=
The function separates the LU matrix into two separate ones
@par X - matrix
@par n - size of matrix
=#
function separate(X::SparseMatrixCSC,n::Int64)
    L = spzeros(Float64,n,n)
    U = spzeros(Float64,n,n)

    for i in 1:n
        L[i,i] = 1.0
    end
    for i in 1:n
        for j in 1:i-1
            L[i,j] = X[i,j]
        end
        for j in i:n
            U[i,j] = X[i,j]
        end
    end
    return L,U
end

end #module