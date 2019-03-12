inits [] = [[]]
inits x = inits(init x)++[x]
