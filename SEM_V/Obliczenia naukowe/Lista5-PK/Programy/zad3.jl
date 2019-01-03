#@author Piotr Klepczyk

module zad3
export calcResult, clacRecult_chosen

#=
The function counts the vector x for the LU distribution
@par A - matrix
@par b - Vector
@par n - size of matrix
@par l - size of small matrix
@ret x - vector
=#
function calcResult(A::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64)
    for i in 1:n-1 
        for j in i+1:getRow_Section(i,n,l)
            b[j] = b[j] - (A[j,i]*b[i])
        end
    end

    x = spzeros(n)

    x[n] = b[n]/A[n,n]
    for i in n-1:-1:1 #row
        b_value = b[i]
        for j in getColumn_Section(i,n,l):-1:i+1 #column
            b_value = b_value - (x[j]*A[i,j])
        end
        x[i] = b_value/A[i,i]
    end
    return x
end

#=
The function counts the vector x for the LU distribution with the main element selection
@par A - matrix
@par b - Vector
@par n - size of matrix
@par l - size of small matrix
@par swaped - swap table
@ret x - vector
=#
function clacRecult_chosen(A::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64, swaped::Vector{Int64})
    for i in 1:n-1 
        for j in i+1:getRow_Section(i,n,l) #row
            b[swaped[j]] = b[swaped[j]] - (A[swaped[j],i]*b[swaped[i]])
        end
    end

    x = spzeros(n)

    x[swaped[n]] = b[swaped[n]]/A[swaped[n],n]
    for i in n-1:-1:1 #row
        b_value = b[swaped[i]]
        for j in getColumn_Section_chose(i,n,l):-1:i+1 #column
            b_value = b_value - (x[swaped[j]]*A[swaped[i],j])
        end
        x[swaped[i]] = b_value/A[swaped[i],i]
    end
    return x
end

#=
The function calculates the maximum range of rows
@par x - alctual row
@par n - size of matrix
@par l - size of small matrix
@ret r - max row
=#
function  getRow_Section(x::Int64,n::Int64,l::Int64)
    r = l + Int(floor(x/l))*l
    if r > n
        r = n
    end
    return r
end

#=
The function calculates the maximum range of column
@par x - alctual row
@par n - size of matrix
@par l - size of small matrix
@ret c - max column
=#
function getColumn_Section(x::Int64,n::Int64,l::Int64)
    c = x + l
    if c > n
        c = n
    end
    return c
end

#=
The function calculates the maximum range of column for function with choose the main element
@par x - alctual row
@par n - size of matrix
@par l - size of small matrix
@ret c - max column
=#
function getColumn_Section_chose(x::Int64,n::Int64,l::Int64)
    c = 2*l + Int(floor((x-1)/l))*l
    if c > n
        c = n
    end
    return c
end

end #module