#@author: Piotr Klepczyk

#p(n+1) = p(n) + r*p(n)*(1-p(n))

#=
get result for recursive equation in Float32
@par p0 - value for p(0)
@par r - constant
@par n - number of iteration
=#
function calc_f32(p0,r,n)
    p = Float32(p0 + Float32(r*p0*(Float32(1-p0))))
    println(Float32(p))
    n=n-1
    if n>0
        calc_f32(p,r,n)
    elseif n==0
        return p
    end
end

#=
get result for recursive equation in Float64
@par p0 - value for p(0)
@par r - constant
@par n - number of iteration
=#
function calc_f64(p0,r,n)
    p = Float64(p0 + Float64(r*p0*(Float64(1-p0))))
    println(Float64(p))
    n=n-1
    if n>0
        calc_f64(p,r,n)
    elseif n==0
        return p
    end
end

println("1)")
a = calc_f32(0.01,3,40)
println()
a = calc_f32(0.01,3,10)
a = calc_f32(0.722,3,30)
println()
println("2)")
a = calc_f64(0.01,3,40)