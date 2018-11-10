#@author: Piotr Klepczyk

function hilb(n::Int)
# Function generates the Hilbert matrix  A of size n,
#  A (i, j) = 1 / (i + j - 1)
# Inputs:
#	n: size of matrix A, n>=1
#
#
# Usage: hilb (10)
#
# Pawel Zielinski
        if n < 1
         error("size n should be >= 1")
        end
        return [1 / (i + j - 1) for i in 1:n, j in 1:n]
end

function matcond(n::Int, c::Float64)
# Function generates a random square matrix A of size n with
# a given condition number c.
# Inputs:
#	n: size of matrix A, n>1
#	c: condition of matrix A, c>= 1.0
#
# Usage: matcond (10, 100.0);
#
# Pawel Zielinski
        if n < 2
         error("size n should be > 1")
        end
        if c< 1.0
         error("condition number  c of a matrix  should be >= 1.0")
        end
        (U,S,V)=svd(rand(n,n))
        return U*diagm(linspace(1.0,c,n))*V'
end

#=
calculate relative delta
@par x-exact value
@par y-the value is calculated
=#
function relative_delta(x,y)
	return norm(y-x)/norm(y)
end 

#=
calculate value for Hilbert's matrix
@par n-size of matrix
=#
function solution_for_hilb(n)
A = hilb(n)
x = ones(n,1)
b = A*x
x1 = A\b #Gauss elimination
x2 = inv(A)*b #second method
println("Gauss:	",x1)
println("Wskaźnik -> ",cond(A))
println("relative_delta:	",relative_delta(x1,x))
println("Second method:	",x2)
println("relative_delta:	",relative_delta(x2,x))
end

#=
calculate value for random matrix
@par n-size of matrix
@par c-condition of matrix
=#
function solution_for_rand(n,c)
	A = matcond(n,c)
	x = ones(n,1)
	b = A*x
	x1 = A\b #Gauss elimination
	x2 = inv(A)*b #second method
	println("Gauss:	",x1)
	println("relative_delta:	",relative_delta(x1,x))
	println("Second method:	",x2)
	println("relative_delta:	",relative_delta(x2,x))
end


println("Macież Hilberta")
for i in 2:20
	println("dla: ",i)
	solution_for_hilb(i)
end

println()

println("Macież losowa")
for i in (5,10,20)
	println("dla: ",i)
	for j in (1.0,10.0,10.0^3,10.0^7,10.0^12,10.0^16)
		println("dla: ",j)
		solution_for_rand(i,j)
	end 
end