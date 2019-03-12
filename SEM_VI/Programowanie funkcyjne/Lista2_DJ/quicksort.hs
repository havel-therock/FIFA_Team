qs []     = []
qs (x:xs) = qs [t| t <- xs, t <= x] ++ [x] ++  qs [t| t <- xs, t > x] 

quicksort []     = []
quicksort (x:xs) = (quicksort lesser) ++ [x] ++ (quicksort greater)
    where
        lesser  = filter (< x) xs
        greater = filter (>= x) xs
