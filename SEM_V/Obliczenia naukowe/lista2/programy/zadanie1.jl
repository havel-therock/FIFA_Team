#author: Jan Sieradzki
#nr_indeksu: 236441

# Creating vectors

x = [2.718281828, -3.141592654, 1.414213562, 0.577215664, 0.301029995]
y = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]


# a) "forward"

function exc5a32()
    Sum = Float32(0.0)
    for i=1:5
        Sum=Float32(Sum+Float32(Float32(x[i])*Float32(y[i])))
    end
    return Sum
end
function exc5a64()
    Sum = Float64(0.0)
    for i=1:5
         Sum=Float64(Sum+Float64(Float64(x[i])*Float64(y[i])))
    end
    return Sum
end


# b) "backward"

function exc5b32()
    Sum = Float32(0.0)
    for i=1:5
        Sum=Float32(Sum+Float32(Float32(x[6-i])*Float32(y[6-i])))
    end
    return Sum
end
function exc5b64()
    Sum = Float64(0.0)
    for i=1:5
        Sum=Float64(Sum+Float64(Float64(x[6-i])*Float64(y[6-i])))
    end
    return Sum
end

# Multipling

T1a = Float32(Float32(x[1]) * Float32(y[1]))
T2a = Float32(Float32(x[2]) * Float32(y[2]))
T3a = Float32(Float32(x[3]) * Float32(y[3]))
T4a = Float32(Float32(x[4]) * Float32(y[4]))
T5a = Float32(Float32(x[5]) * Float32(y[5]))
T1b = Float64(Float64(x[1]) * Float64(y[1]))
T2b = Float64(Float64(x[2]) * Float64(y[2]))
T3b = Float64(Float64(x[3]) * Float64(y[3]))
T4b = Float64(Float64(x[4]) * Float64(y[4]))
T5b = Float64(Float64(x[5]) * Float64(y[5]))

# Function shows multiplications results

function multiply32()
	println("Multiplings - single precision:")
        println("x[1]*y[1] = ",T1a)
        println("x[2]*y[2] = ",T2a)
	println("x[3]*y[3] = ",T3a)
	println("x[4]*y[4] = ",T4a)
	println("x[5]*y[5] = ",T5a)
end
function multiply64()
	println("Multiplings - double precision:")
        println("x[1]*y[1] = ",T1b)
        println("x[2]*y[2] = ",T2b)
	println("x[3]*y[3] = ",T3b)
	println("x[4]*y[4] = ",T4b)
	println("x[5]*y[5] = ",T5b)
end

# 4 > 1 > 5 > 0 > 3 > 2

# c) "from biggest to smallest"

function exc5c32()
	Sumplus = Float32(Float32(T4a+T1a)+T5a)
	Summinus = Float32(T2a+T3a)
	Sum = Float32(Sumplus+Summinus)	
    return Sum
end
function exc5c64()
	Sumplus = Float64(Float64(T4b+T1b)+T5b)
	Summinus = Float64(T2b+T3b)
	Sum = Float64(Sumplus+Summinus)	
    return Sum
end


# d) "from smallest to biggest"

function exc5d32()
	Sumplus = Float32(Float32(T5a+T1a)+T4a)
	Summinus = Float32(T3a+T2a)
	Sum = Float32(Sumplus+Summinus)	
    return Sum
end
function exc5d64()
	Sumplus = Float64(Float64(T5b+T1b)+T4b)
	Summinus = Float64(T3b+T2b)
	Sum = Float64(Sumplus+Summinus)	
    return Sum
end


#Answer

function exc5()
	println("Accurate result: Sum = -1.00657107000000e-11")
	println("Algorithm A: \n single: Sum = ", exc5a32())
	println(" double: Sum = ", exc5a64())
	println("Algorithm B: \n single: Sum = ", exc5b32())
	println(" double: Sum: S = ", exc5b64())
	println("Algorithm C: \n single: Sum = ", exc5c32())
	println(" double: Sum = ", exc5c64())
	println("Algorithm D: \n single: Sum = ", exc5d32())
	println(" double: Sum = ", exc5d64())
end

exc5()
