#@author Piotr Klepczyk

module inout
export inMatrix, inVector, outVector

#=
The function reads the matrix from the file
@par filename - file name with the matrix
@ret m - matrix
@ret n - size of matrix
@ret l - size od small matrix
=#
function inMatrix(filename::String)
    line = []

    open(filename) do FILE
        line = readlines(FILE)
    end
    
    n,l = [parse(Int64,i) for i in split(line[1])]
    m = spzeros(n, n) #tworzy zerowa macierz

    for li in line[2:end]
        x, y, v = split(li)
        x = parse(Int64, x)
        y = parse(Int64, y)
        v = parse(Float64, v)
        m[x, y] = v
    end

    return m, n, l
end #inMatrix

#=
The function reads the vector from the file
@par filename - file name with the vector
@ret v - vector
@ret n - size of vector
=#
function inVector(filename::String)
    line = []

    open(filename) do FILE
        line = readlines(FILE)
    end

    n = parse(Int64,line[1])
    v = spzeros(n)

    i = 1
    for j in line[2:end]
        v[i] = parse(Float64,j)
        i = i+1
    end
    return v, n
end #inVector

#=
The function save the vector to the file
@par filename - file name for new file
@par v - vector
=#
function outVector(filename::String,v::SparseVector)
    open(filename,"w") do FILE
        for n in v
            @printf(FILE, "%0.15f\n",n)
        end
    end
end #outVector

end #module