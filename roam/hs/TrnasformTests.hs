import qualified Transform as Tr
import qualified Matrix as M
main = do
  let t = Tr.transform2f (M.Mat3D
                           1 0 0
                           0 1 0
                           0 0 1)
  print $ (show t)
