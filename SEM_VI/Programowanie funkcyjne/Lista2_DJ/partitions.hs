partitions [] = [([], [])]
partitions (x : xs) =
  let parts = partitions xs
  in [(x : ys, zs) | (ys, zs) <- parts] ++ [(ys, x : zs) | (ys, zs) <- parts]
