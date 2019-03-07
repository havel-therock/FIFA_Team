showFibs n = take n fibs

fibs = 0 : 1 : [n | x <-[2..], let n = ((fibs !! (x-1)) + (fibs !! (x-2)))]
