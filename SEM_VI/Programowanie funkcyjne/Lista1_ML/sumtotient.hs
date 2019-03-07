sumtotient a = sum (maptotient (filter  (divisors a) [1.. a `div` 2]))
 where divisors a b =  a `mod` b == 0 

totient 1 = 1
totient x =  length $ filter (coprime x) [1..x-1]
 where coprime x b = gcd x b == 1

maptotient a= map totient a
