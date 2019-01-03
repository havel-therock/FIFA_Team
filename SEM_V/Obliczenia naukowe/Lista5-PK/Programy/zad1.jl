#@author Piotr Klepczyk

module zad1
export gaussElimination, gaussElimination_chosen

#=
The function performs gauss elimination
@par A - matrix
@par b - vector
@par n - size of matrix and length of vector
@par l - size small matrix into matrix A
@ret reslt od resultCalc function
=#
function gaussElimination(A::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64)
    for i in 1:n-1 
        for j in i+1:getRow_Section(i,n,l) #row
            m = A[j,i]/A[i,i]
            A[j,i] = A[j,i] - (m*A[i,i])
            for k in i+1:getColumn_Section(i,n,l) #column
                A[j,k] = A[j,k] - (m*A[i,k])
            end
            b[j] = b[j] - (m*b[i])
        end
    end

    return resultCalc(A,b,n,l)
end

#=
The function performs gauss elimination with choose the main element
@par A - matrix
@par b - vector
@par n - size of matrix and length of vector
@par l - size small matrix into matrix A
@ret reslt od resultCalc function
=#
function gaussElimination_chosen(A::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64)
    swaped = Vector{Int64}(n)
    for i in 1:n
        swaped[i] = i
    end
    for i in 1:n-1 
        maxrow = swaped[i]
        maxrow_pos = i
        for j in i:getRow_Section(i,n,l)
            if abs(A[maxrow,i])<abs(A[swaped[j],i])
                maxrow = swaped[j]
                maxrow_pos = j
            end
        end
        #swap
        if maxrow!=swaped[i]
            x = swaped[i]
            swaped[i] = swaped[maxrow_pos]
            swaped[maxrow_pos] = x
        end #end swap

        for j in i+1:getRow_Section(i,n,l) #row
            m = A[swaped[j],i]/A[swaped[i],i]
            A[swaped[j],i] = A[swaped[j],i] - (m*A[swaped[i],i])
            for k in i+1:getColumn_Section_chose(i,n,l) #column
                A[swaped[j],k] = A[swaped[j],k] - (m*A[swaped[i],k])
            end
            b[swaped[j]] = b[swaped[j]] - (m*b[swaped[i]])
        end
    end

    return resultCalc_chose(A,b,n,l,swaped)
end

#=
The function calculates the values of the x vector with choose the main element
@par A - matrix
@par b - vector
@par n - size of matrix and length of vector
@par l - size small matrix into matrix A
@par swaped - swap table
@ret x - vector
=#
function resultCalc_chose(A::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64,swaped::Vector{Int64})
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
The function calculates the values of the x vector
@par A - matrix
@par b - vector
@par n - size of matrix and length of vector
@par l - size small matrix into matrix A
@ret x - vector
=#
function resultCalc(A::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64)
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

#=
The function determines the vector b
@par A - matrix
@par n - size of matrix
@par l - size of small matrix
@ret b - vector
=#
function calcVector(A::SparseMatrixCSC,n::Int64,l::Int64)
    b = spzeros(n)
    for i in 1:n
        min = (l * Int(floor((i-1) / l)))
        if min<1
            min = 1
        end
        for j in min:getColumn_Section(i,n,l)
            b[i] = b[i] + A[i,j]
        end
    end
    println(b)
    return b
end

end #module