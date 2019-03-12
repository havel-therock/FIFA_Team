factorial n = if (n < 2) then 1 else n * factorial (n-1)
zero n = zeros (factorial n)
zeros n = if ( n `mod` 10 == 0)then(1+zeros ( n `div` 10)) else  0
