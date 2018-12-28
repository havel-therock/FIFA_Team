#author: Jan Sieradzki
#nr_indeksu: 236441

include("blockmat.jl")
include("blocksys.jl")
using blocksys, matrixgen, Base.Test

blockmat(16,8,100.0,"tests/toTests.txt")
@test_throws SystemError doAlgorithms("fdgg","Dane16_1_1/b.txt","results.txt",false,false)

#LU tests
#no choose
(A,n,l) = loadMatrix("tests/toTests.txt")
A2 = Array{Float64}(n,n)
for i= 1 : n
	for j=1 : n
		A2[i,j]=A[i,j]
	end
end
x = loadVector("tests/b.txt") # array ones(16) 
b = calculateVectorB(A,n,l) #calculate b, (assume x is array ones(16))
L = Array{Float64}(n,n)
U = Array{Float64}(n,n)
generateLU(A, n, l)
for i= 1 : n
	for j=1 : n
		if(i>j)
			L[i,j]=A[i,j]
			U[i,j]=0
		elseif(i<j)
			L[i,j]=0
			U[i,j]=A[i,j]
		else
			L[i,j]=1
			U[i,j]=A[i,j]
		end
	end
end
 
M = L*U
@test M == L*U
@test A != A2
@test A2≈M
#choose
(A,n,l) = loadMatrix("tests/toTests.txt")
A2 = Array{Float64}(n,n)
for i= 1 : n
	for j=1 : n
		A2[i,j]=A[i,j]
	end
end
x = loadVector("tests/b.txt") # array ones(16) 
b = calculateVectorB(A,n,l) #calculate b, (assume x is array ones(16))
L = Array{Float64}(n,n)
U = Array{Float64}(n,n)
A3 = Array{Float64}(n,n)
p=chooseGenerateLU(A, n, l)
for i= 1 : n
	for j=1 : n
		A3[i,j]=A2[p[i],j]
		if(i>j)
			L[i,j]=A[p[i],j]
			U[i,j]=0
		elseif(i<j)
			L[i,j]=0
			U[i,j]=A[p[i],j]
		else
			L[i,j]=1
			U[i,j]=A[p[i],j]
		end
	end
end
#println(A3)
M = L*U
#println(M)
@test A3≈M
#Calculateing A*x=b function tests
(A,n,l) = loadMatrix("tests/toTests.txt")
x = loadVector("tests/b.txt") # array ones(16) 
b = calculateVectorB(A,n,l) #calculate b, (assume x is array ones(16))

gauss = gaussElimination(A, n, l, b)
gauss2 = gaussElimination(A, n, l, b)

generateLU(A, n, l)
lu = solveWithLU(A, n, l, b)

p = chooseGenerateLU(A, n, l)
lu2 = chooseSolveWithLU(A, p, n, l, b)
#Testing if gauss elimation works properly
@test x≈gauss
#Testing if gauss elimation with choosing works properly
@test x≈gauss2
#Testing if LU calculate method works properly
@test x≈lu
#Testing if LU calculate method with choosing works properly
@test x≈lu2


println("TESTS 1.1 !!!!!!!!!")

doAlgorithms("Dane16_1_1/A.txt","Dane16_1_1/b.txt","",false,false)

doAlgorithms("Dane16_1_1/A.txt","Dane16_1_1/b.txt","",true,false)

doAlgorithms("Dane16_1_1/A.txt","Dane16_1_1/b.txt","",false,true)

doAlgorithms("Dane16_1_1/A.txt","Dane16_1_1/b.txt","",true,true)


println("TESTS 1.2 !!!!!!!!!")

doAlgorithms("Dane16_1_1/A.txt","","results.txt",false,false)

doAlgorithms("Dane16_1_1/A.txt","","results.txt",true,false)

doAlgorithms("Dane16_1_1/A.txt","","results.txt",false,true)

doAlgorithms("Dane16_1_1/A.txt","","results.txt",true,true)


println("TESTS 2.1 !!!!!!!!!")

doAlgorithms("Dane10000_1_1/A.txt","Dane10000_1_1/b.txt","",false,false)

doAlgorithms("Dane10000_1_1/A.txt","Dane10000_1_1/b.txt","",true,false)

doAlgorithms("Dane10000_1_1/A.txt","Dane10000_1_1/b.txt","",false,true)

doAlgorithms("Dane10000_1_1/A.txt","Dane10000_1_1/b.txt","",true,true)

println("TESTS 2.2 !!!!!!!!!")

doAlgorithms("Dane10000_1_1/A.txt","","results.txt",false,false)

doAlgorithms("Dane10000_1_1/A.txt","","results.txt",true,false)

doAlgorithms("Dane10000_1_1/A.txt","","results.txt",false,true)

doAlgorithms("Dane10000_1_1/A.txt","","results.txt",true,true)

println("TESTS 3.1 !!!!!!!!!")

doAlgorithms("Dane50000_1_1/A.txt","Dane50000_1_1/b.txt","results.txt",false,false)

doAlgorithms("Dane50000_1_1/A.txt","Dane50000_1_1/b.txt","results.txt",true,false)

doAlgorithms("Dane50000_1_1/A.txt","Dane50000_1_1/b.txt","results.txt",false,true)

doAlgorithms("Dane50000_1_1/A.txt","Dane50000_1_1/b.txt","results.txt",true,true) 

println("TESTS 3.2 !!!!!!!!!")

doAlgorithms("Dane50000_1_1/A.txt","","results.txt",false,false)

doAlgorithms("Dane50000_1_1/A.txt","","results.txt",true,false)

doAlgorithms("Dane50000_1_1/A.txt","","results.txt",false,true)

doAlgorithms("Dane50000_1_1/A.txt","","results.txt",true,true) 


