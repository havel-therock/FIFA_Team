#=
#   @author Mateusz Laskowski
=#
################# HELPING METHODS #################
################# TO DO GAUSSIAN ELIMINATION #################

module gaussian

export readMatrix, readVector

function readMatrix(filepath::String)
# function that reads the matrix from a text file (*.txt)
    line = []

    open(filepath) do FILE
        line = readlines(FILE)
    end

    n, l = [parse(Int64, x) for x in split(line[1])]
    Matrix = spzeros(n, n)

    for li in line[2:end]
        x, y, value = split(li)
        x = parse(Int64, x)
        y = parse(Int64, y)
        value = parse(Float64, value)
        Matrix[x, y] = value
    end

    return Matrix, n, l
end

function readVector(filepath::String)
# function that reads the vector of right pages "b" from a text file (*.txt)
    line = []

    open(filepath) do FILE
        line = readlines(FILE)
    end

    n = parse(Int64, line[1])
    Vector = spzeros(n)

    for(i, l) in enumerate(line[2:end])
        Vector[i] = parse(Float64, l)
    end

    return Vector, n
end

function columnRange(row::Int64, n::Int64, l::Int64)
    minMul = trunc(Int64, (row - 1) / l) - 1
    maxMul = minMul + 3
    min = (minMul * l + 1) > 1 ? (minMul * l + 1) : 1
    max = (maxMul * l) < n ? maxMul * l : n
    return min:max
end

function combineRanges(upperRow::Int64, lowerRow::Int64, n::Int64, l::Int64)
    upper = columnRange(upperRow, n, l)
    lower = columnRange(lowerRow, n, l)
    if(upper[end] >= lower[1])
        return collect(lower[1] : upper[end])
    else
        return vcat(collect(lower), collect(upper))
    end
end

function backwardSubstitution(U::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64)
    x = spzeros(n)
    for row in n:-1:1
        s = b[row]
        # for col in i+1:n
        # range = (row - 2 * l > 1 ? row - 2 * l : 1) : (row + 2 * l > n ? n : row + 2 * l)
        for column in columnRange(row, n, l)
            # for column in range
            s = s- U[row, column] * x[column]
        end
        x[row] = s / U[row, row]
    end
    return x
end

function doGaussianElimination(A::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64, boolPivot::Bool, boolSolve::Bool) 
# function solving the Ax = b system using the Gaussian Elimination method
    # perform Gaussian Elimination - bottom left triangle filled with zeros
    L = spzeros(n, n)
    U = copy(A)
    maxRowIndex = 0

    # for all columns in matrix 
    for k in 1:n-1
        limitIndex = k + 2 * l > n ? n : k + 2 * l  #  DOBRE?

        # if elimination with a pivot
        if(boolPivot)
            max = 0     # starting maximum value

            # find maximum value
            for j = k:limitIndex    # [row, column]
                if(abs(U[j, k]) > max)
                    max = abs(U[j, k])
                    maxRowIndex = j
                end
            end

            if(maxRowIndex != k)
                for j = combineRanges(k, maxRowIndex, n, l)
                    U[k, j], U[maxRowIndex, j] = U[maxRowIndex, j], U[k, j]
                end
                b[k], b[maxRowIndex] = b[maxRowIndex], b[k]
            end
        end

        # check if the value doesn't oscillate near zero
        if(abs(U[k, k]) < eps(Float64))
            zeroValue = U[k, k]
            emptyMatrix = []
            println("ERROR: U[" + k + ", " + k + "] = " + zeroValue + " < epsilon for Float64")
            return emptyMatrix, 1
        end

        # for all rows to zero in column
        for i in k+1 : limitIndex 
            temp = U[i, k] / U[k, k]
            L[i, k] = temp
            U[i, k] = 0.0

            # for all columns in row
            for j in k+1 : limitIndex
                U[i, j] = U[i, j] - temp * U[k, j]      # multiply by first row
            end
            b[i] = b[i] - temp * b[k]
        end
    end

    if(boolSolve)
        x = backwardSubstitution(U, b, n, l)
        return x, 0
    else # nie działa odwrotnie
        for i in 1:n
            L[i, i] = 1.0
        end
        return (L, U), 0
    end

end

function gaussianElimination(A::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64) 
# function calling the Gaussian Elimination method without Pivot
    x, error = doGaussianElimination(copy(A), copy(b), n, l, false, true)
    return sparse(x), error
end

function gaussianEliminationWithPivot(A::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64)
    x, error = doGaussianElimination(copy(A), copy(b), n, l, true, true)
    return sparse(x), error
end

function writeVector(vector::SparseVector, filepath::String)
# function that saves the received vector to a text file (*.txt)
    open(filepath, "w") do FILE
        for n in vector
            @printf(FILE, "%0.15f\n", n)
        end
    end
end


end # end module