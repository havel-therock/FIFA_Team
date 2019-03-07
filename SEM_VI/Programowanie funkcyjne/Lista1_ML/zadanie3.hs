showEuler n = take n euler

euler = [x | x <- [1..], gcd x 10 == 1]