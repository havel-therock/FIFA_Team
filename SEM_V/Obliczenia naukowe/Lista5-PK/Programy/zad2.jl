#@author Piotr Klepczyk

module zad2
export distributionLU, distributionLU_chosen

#=
The function performs the LU distribution
@par A - matrix
@par b - Vector
@par n - size of matrix
@par l - size of small matrix
@ret A - matrix LU
=#
function distributionLU(A::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64)
    for i in 1:n-1 
        for j in i+1:getRow_Section(i,n,l) #row
            m = A[j,i]/A[i,i]
            A[j,i] = m
            for k in i+1:getColumn_Section(i,n,l) #column
                A[j,k] = A[j,k] - (m*A[i,k])
            end
        end
    end
    return A
end

#=
The function performs the LU distribution with the main element selection
@par A - matrix
@par b - Vector
@par n - size of matrix
@par l - size of small matrix
@ret A - matrix LU
@ret swaped - swap table
=#
function distributionLU_chosen(A::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64)
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
            A[swaped[j],i] = m
            for k in i+1:getColumn_Section_chose(i,n,l) #column
                A[swaped[j],k] = A[swaped[j],k] - (m*A[swaped[i],k])
            end
        end
    end
    return A,swaped
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