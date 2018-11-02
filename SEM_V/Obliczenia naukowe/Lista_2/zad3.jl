#=
#   @author Mateusz Laskowski
=#

################# MATRIX HILB & RANDOM #################

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

function delta(z, x)
    return norm(z - x)/norm(x);
end

function computeHilb(n)
    A = hilb(n);
    O = ones(n, 1);
    b = A * O;
    gauss = A \ b;          # b / A
    inverted = inv(A) * b;
    print(n, " -> cond=", cond(A), " | gauss=", delta(gauss, O), "| inv=", delta(inverted, O), "\n");
end

function computeRand(n, c)
    A = matcond(n, 10^c);
    O = ones(n, 1);
    b = A * O;
    gauss = A \ b;          # b/ A
    inverted = inv(A) * b;
    print(n, " -> cond=", c ," | gauss=", delta(gauss, O), "| inv=", delta(inverted, O), "\n");
end

print("Hilbert matrix\n");
for x = 1:20
    computeHilb(x);
end

print("\n");
print("Random matrix with condition cumber c\n");
for x = [5, 10, 20], c = [1.0, 3.0, 7.0, 12.0, 16.0] 
    computeRand(x, c);
end