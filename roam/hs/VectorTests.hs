import qualified Vector as V

main :: IO()
main = do
  let v = V.vec2f 0 1
  print $ (show (V.norm v))
