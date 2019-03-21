--convert
fromIntegral :: (Num b, Integral a) => a -> b
fromInteger :: Num a => Integer -> a
toInteger:: Integral a => a -> Integer
realToFrac:: (Real a, Fractional b) => a -> b
fromRational :: Fractional a => Rational -> a
toRational :: Real a => a -> Rational
float2Double :: Float -> Double
double2Float :: Double -> Float

--Fibonacci 
fib = 1 : 1 : [a + b | (a, b) <- zip fib (tail fib)]
fibs a = fib!!a

--Middle 
middle x y z = x + y + z - mymin - mymax
	where	mymin = min x $ min y z
		mymax = max x $ max y z

--Quick sort 
--wykład
qs []     = []
qs (x:xs) = qs [t| t <- xs, t <= x] ++ [x] ++  qs [t| t <- xs, t > x] 

quicksort []     = []
quicksort [a]     = [a]
quicksort [a,b] = if (a>= b) then [b, a] else [a, b] 
quicksort (x:xs) = (quicksort lesser) ++ [x] ++ (quicksort greater)
    where
        lesser  = filter (< x) xs
        greater = filter (>= x) xs

--inits
inits [] = [[]]
inits x = inits(init x)++[x]

initss [] = [[]]
initss xs = [take i xs | i <- [0..length xs]]

--partitions 
partitions [] = [([], [])]
partitions (x : xs) =
 let parts = partitions xs in [(x:ys, zs) | (ys, zs) <- parts]  ++ [(ys, x : zs) | (ys, zs) <- parts]


-- number
nub [] = []
nub (x:xs) =  [x] ++(nub (filter (/= x) xs))

--permutations
permutate [] = [[]]
permutate l = [a:x | a <- l, x <- (permutate $ filter (\x -> x /= a) l)]

--zeros
factorial n = product [1..n]
zero n = zeros (factorial n)
zeros n = if ( n `mod` 10 == 0)then(1+zeros ( n `div` 10)) else  0

