fib = 1 : 1 : [a + b | (a, b) <- zip fib (tail fib)]
fibs a = fib!!a


