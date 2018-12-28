#author: Jan Sieradzki
#nr_indeksu: 236441


module blocksys
export doAlgorithms, swap, calculateVectorB, gaussElimination , chooseGaussElimination, generateLU, solveWithLU , chooseGenerateLU, chooseSolveWithLU, writeToFile, loadVector, loadMatrix


# Function, that calculate A*x = b with choosen method, with data from matrixFile and vectrFile, saves result in outFile
# IN
# matrixFile - input file of matrix A
# vectorFile - input file of vector b, optional (if you want skip, give empty string)
# outFile - place, where algorithm will output results, optional (if you want skip, give empty string)
# choose - bool, tells if it choose main elements during compiling	
# lu - bool, tells if it should use LU matrix
function doAlgorithms(matrixFile::String,vectorFile::String, outFile::String,choose::Bool,lu::Bool )
	(A,n,l) = loadMatrix(matrixFile)
	bool = false
	if vectorFile != ""
		b = loadVector(vectorFile)
		println("Version with given b")
	else
		b = calculateVectorB(A,n,l)
		println("Version with calculateing b")
		bool = true;
	end
	#println("!!!!!!!!!!")	
	#x = A \ b
	#println(x)
	if(!lu)
		if (choose)
			println("chooseGaussElimination")
			@time x = chooseGaussElimination(A, n, l, b)
		else
			println("GaussElimination")
			@time x = gaussElimination(A, n, l, b)
		end
	else
		if (choose)
			println("chooseGenerateLU")
			@time p = chooseGenerateLU(A, n, l)
			#println(A)
			@time x = chooseSolveWithLU(A, p, n, l, b)
		else
			println("generateLU")
			@time generateLU(A, n, l)
			#println(A)
			@time x = solveWithLU(A, n, l, b)
		end
	end
	#println(x)
	writeToFile(outFile, bool, x, n)
end

#function that swaps two values
function swap(swaps::Vector{Int64},x::Int64, y::Int64)
    temp = swaps[x]
    swaps[x] = swaps[y]
    swaps[y] = temp
end

# Function that calculates vector b in A*x=b
# IN
# A - matrix loaded from the file 
# n - size of matrix
# l - size of single block
# OUT	
# b - calculated vector b
function calculateVectorB(A::SparseMatrixCSC{Float64, Int64}, n::Int64, l::Int64)
	b = zeros(Float64, n)
	for i = 1 : n
		startCol = l * Int(floor((i-1) / l))
		stopCol = l + l * Int(floor((i-1) / l))
		if startCol<1
			startCol=1
		end
		if stopCol>n
			stopCol=n
		end	
	
		if i + l <= n
			b[i] += A[i, i+l]
		end
		for j = startCol : stopCol
			b[i] += A[i, j]
		end
	end
	return b
end



# Function that calculates x in equation A*x = b, without swaping rows
# IN
# A - input matrix NxN, that has special attributes
# n - size of matrix
# l - size of single block 
# b - vector from equation A*x = b
# OUT
# x - vector that is solve equation A*x = b
function gaussElimination(A::SparseMatrixCSC{Float64, Int64}, n::Int64, l::Int64, b::Vector{Float64})
	for k = 1 : n-1
		limitCol = k + l 
		limitRow = l + Int(floor(k/l))*l
		if limitCol>n
			limitCol=n
		end
		if limitRow>n
			limitRow=n
		end
		if abs(A[k,k]) < eps(Float64)
			println("Divide by 0")
			return 0
		end
		for i = k+1 : limitRow
			c = A[i, k] / A[k, k]
			A[i, k] = 0
			for j = k+1 : limitCol
				A[i, j] = A[i, j] - c * A[k, j]
			end
			b[i] = b[i] - c * b[k]
		end
	end
	
	x = Array{Float64}(n)

	for i = n : -1 : 1
		sum = 0.0
		limitCol = i + l
		if limitCol>n
			limitCol=n
		end
		for j = i + 1 : limitCol
			sum += A[i, j] * x[j]
		end
		x[i] = (b[i] - sum) / A[i, i]
	end
	return x
end


# Function that calculates x in equation A*x = b, with swaping rows
# IN
# A - input matrix NxN, that has special attributes
# n - size of matrix
# l - size of single block 
# b - vector from equation A*x = b
# OUT
# x - vector that is solve equation A*x = b
function chooseGaussElimination(A::SparseMatrixCSC{Float64, Int64}, n::Int64, l::Int64, b::Vector{Float64})
	swaps = Vector{Int64}(n)
	for k = 1 : n
		swaps[k] = k
	end

	for k = 1 : n-1
		limitCol = 2*l + Int(floor((k-1)/l))*l
		limitRow = l + Int(floor(k/l))*l
		if limitCol>n
			limitCol=n
		end
		if limitRow>n
			limitRow=n
		end
		swaped = k
		for j = k : limitRow
			if abs(A[swaps[k],k]) < abs(A[swaps[j],k])
				swap(swaps,k,j)
			end
		end
		if abs(A[swaps[k],k]) < eps(Float64)
			println("Unable to solve that")
			return 0
		end
		for i = k+1 : limitRow
			c = A[swaps[i], k] / A[swaps[k], k]
			A[swaps[i], k] = 0
			for j = k+1 : limitCol
				A[swaps[i], j] = A[swaps[i], j] - c * A[swaps[k], j]
			end
			b[swaps[i]] = b[swaps[i]] - c * b[swaps[k]]
		end
	end
	
	x = Array{Float64}(n)

	for i = n : -1 : 1
		sum = 0.0
		limitCol = 2*l + Int(floor((i-1)/l))*l
		if limitCol>n
			limitCol=n
		end
		for j = i + 1 : limitCol
			sum += A[swaps[i], j] * x[j]
		end
		x[i] = (b[swaps[i]] - sum) / A[swaps[i], i]
	end
	return x

end

# Function that calculates matrixs LU from matrix A, without swaping rows, it saves LU in the place of matrix A
# IN
# A - input matrix NxN, that has special attributes
# n - size of matrix
# l - size of single block 
function generateLU(A::SparseMatrixCSC{Float64, Int64}, n::Int64, l::Int64)
	for k = 1 : n-1
		limitCol = k + l 
		limitRow = l + Int(floor(k/l))*l
		if limitCol>n
			limitCol=n
		end
		if limitRow>n
			limitRow=n
		end
		if abs(A[k,k]) < eps(Float64)
			println("Divide by 0")
			return 0
		end
		for i = k+1 : limitRow
			c = A[i, k] / A[k, k]
			A[i,k] = c
			for j = k+1 : limitCol
				A[i, j] = A[i, j] - c * A[k, j]
			end
		end
	end
end

# Function that calculates x in equation A*x = b, without swaping rows and with A saved as LU matrixs
# IN
# A - input matrix NxN, that has special attributes
# n - size of matrix
# l - size of single block
# b - vector from equation A*x = b 
# OUT
# x - vector that is solve equation A*x = b
function solveWithLU(A::SparseMatrixCSC{Float64, Int64}, n::Int64, l::Int64, b::Vector{Float64})
	x = Array{Float64}(n)
	for k=1 : n
		sum = 0.0
		startCol = Int(floor((k-1)/l))*l
		if startCol<1
			startCol=1
		end
		for j=startCol : k-1
			sum += x[j]*A[k,j]
		end
		x[k]= b[k] - sum		
	end

	for i = n : -1 : 1
		sum = 0.0
		limitCol = i + l
		if limitCol>n
			limitCol=n
		end
		for j = i + 1 : limitCol
			sum += A[i, j] * x[j]
		end
		x[i] = (x[i] - sum) / A[i, i]
	end
	return x

end

# Function that calculates matrixs LU from matrix A, with swaping rows, it saves LU in the place of matrix A
# IN
# A - input matrix NxN, that has special attributes
# n - size of matrix
# l - size of single block 
# OUT
# swaps - Matrix that contatins LU matrixs
function chooseGenerateLU(A::SparseMatrixCSC{Float64, Int64}, n::Int64, l::Int64)
	swaps = Vector{Int64}(n)
	for k = 1 : n
		swaps[k] = k
	end

	for k = 1 : n-1
		limitCol = 2*l + Int(floor((k-1)/l))*l
		limitRow = l + Int(floor((k)/l))*l
		if limitCol>n
			limitCol=n
		end
		if limitRow>n
			limitRow=n
		end
		for j = k+1 : limitRow
			if abs(A[swaps[k],k]) < abs(A[swaps[j],k])
				swap(swaps,k,j)
			end
		end
		if abs(A[swaps[k],k]) < eps(Float64)
			println("Divide by 0")
			return 0
		end
		for i = k+1 : limitRow
			c = A[swaps[i], k] / A[swaps[k], k]
			A[swaps[i],k] = c
			for j = k+1 : limitCol
				A[swaps[i], j] = A[swaps[i], j] - c * A[swaps[k], j]
			end
		end
	end

	return swaps
end

# Function that calculates x in equation A*x = b, with swaping rows and with A saved as LU matrixs
# IN
# A - input matrix NxN, that has special attributes
# swaps - matrix of permutations of rows in A
# n - size of matrix
# l - size of single block
# b - vector from equation A*x = b 
# OUT
# x - vector that is solve equation A*x = b
function chooseSolveWithLU(A::SparseMatrixCSC{Float64, Int64}, swaps::Vector{Int64}, n::Int64, l::Int64, b::Vector{Float64})
	x = Array{Float64}(n)
	for k=1 : n
		sum = 0.0
		startCol = Int(floor((k-1)/l))*l
		if startCol<1
			startCol=1
		end
		for j=startCol : k-1
			sum += x[j]*A[swaps[k],j]
		end
		x[k]= b[swaps[k]] - sum		
	end

	for i in n : -1 : 1
		sum = 0.0
		stopCol = 2*l + l*Int(floor((swaps[i]-1)/l))
		if stopCol>n
			stopCol=n
		end
		for j in i + 1 : stopCol
			sum += x[j]*A[swaps[i],j]
		end
		x[i] = (x[i] - sum) / A[swaps[i],i]
	end
	return x

end

# Function that loads matrix from file
# IN
# file - path to file 
# OUT	
# A - matrix loaded from the file 
# n - size of matrix
# l - size of single block
function loadMatrix(file::String)
	open(file) do FILE
		line = split(readline(FILE))
		n = parse(Int64, line[1])
		l = parse(Int64, line[2])
		
		size = 2*n-2*l+n*l
		column = Array{Int64}(size)
		row = Array{Int64}(size)
		value = Array{Float64}(size)

		i = 1
		while !eof(FILE)
			line = split(readline(FILE))
			row[i] = parse(Int64, line[1])
			column[i] = parse(Int64, line[2])
			value[i] = parse(Float64, line[3])
			i += 1
		end

		A = sparse(row, column, value)
		return A, n, l
	end
end

# Function that loads vector b 
# IN
# file - path to file 
# OUT	
# b - vector loaded from the file 
function loadVector(file::String)
	open(file) do FILE
		n = parse(Int64, readline(FILE))
		b = Array{Float64}(n)
		i = 1
		while !eof(FILE)
			b[i] = parse(Float64, readline(FILE))
			i += 1
		end
		return b
	end
end

# Function that writes solution to file 
# IN
# file - path to file
# bool - tells if it should calculate error 
# x - vector with solution A*x=b
# n - size of matrix
function writeToFile(file::String, bool::Bool, x::Array{Float64}, n::Int64)
	if file != ""
		z = Array{Float64}(n)
		for i = 1 : n
			z[i]=1
		end
		open(file, "w") do FILE
			if bool
				println(FILE, norm(z - x) / norm(x))
				println(norm(z - x) / norm(x))
			end
			for i = 1 : n
				println(FILE, x[i])
			end
		end
	end
end

end

