nub []     = []
nub (x:xs) =  [x] ++(nub diffrent)
    where
        diffrent  = filter (/= x) xs
       
