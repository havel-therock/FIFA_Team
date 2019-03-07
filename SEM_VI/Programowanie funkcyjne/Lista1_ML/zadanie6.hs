newton n k  | k == 0 || n == k = 1
            | n > k && k > 0 = newton (n-1) (k-1) + newton (n-1) k
            | otherwise = -1