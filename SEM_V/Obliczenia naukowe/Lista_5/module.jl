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

    n, l = [parse(Int, x) for x in split(line[1])]
    Matrix = spzeros(n, n)

    for li in line[2:end]
        x, y, value = split(li)
        x = parse(Int, x)
        y = parse(Int, y)
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

    n = parse(Int, line[1])
    Vector = spzeros(n)

    for(i, l) in enumerate(line[2:end])
        Vector[i] = parse(Float64, l)
    end

    return Vector, n
end

end # end module