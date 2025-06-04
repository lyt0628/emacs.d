import Tensor

main :: IO ()
main = do
  let s = scalar 1
      v = vector [1, 2]
  print $ show ((+3) <$> v)
