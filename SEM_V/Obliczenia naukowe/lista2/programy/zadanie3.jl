#author: Jan Sieradzki
#nr_indeksu: 236441

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

function relError(z, x)
    return norm(z - x)/norm(x);
end


#Comparing Hilber matrix results with Gauss and inversion methods 
function hilbAlgorithm()
	print("n	/	COND	/	GAUSS	/	INV\n"); 
	for i in 2:20
		mHilb=hilb(i)
		mX= ones(i,1);
		mB= mHilb*mX
		resultGauss=mHilb\mB
		resultInv=inv(mHilb)*mB
		print(i,"	", cond(mHilb),"	",  relError(resultGauss, mX),"		", relError(resultInv, mX), "\n"); 
	end
	
end

#Comparing random matrix results with Gauss and inversion methods 
function matcondAlgorithm()
	print("\nn	/	COND	/	GAUSS	/	INV\n"); 
	for i = [5, 10, 20], c = [0.0,1.0, 3.0, 7.0, 12.0, 16.0] 
		mHilb=matcond(i,10.0^c)
		mX= ones(i,1);
		mB= mHilb*mX
		resultGauss=mHilb\mB
		resultInv=inv(mHilb)*mB
		print(i,"	", cond(mHilb),"	",  relError(resultGauss, mX),"		", relError(resultInv, mX), "\n");
	end
end

hilbAlgorithm()
matcondAlgorithm()



