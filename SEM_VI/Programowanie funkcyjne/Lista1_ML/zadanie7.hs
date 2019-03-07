showPerfects = print $ perfects 10000

sum_of_factors n = sum [x | x <- [1..n-1], n `mod` x == 0]
perfects n = [x | x <- [1..n], sum_of_factors x == x]
