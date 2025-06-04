import qualified AABB 
import qualified Point as P
import qualified Vector as V

main = do
  let bb = AABB.fromCenterExtent (P.Point2D 0 0) (V.Vec2D 1 1) :: AABB.AABB2f
      bb2 = AABB.quad 2.5 (P.Point2D 3 3) :: AABB.AABB2f
      bb3 = AABB.intersect bb2 bb
      o = AABB.overlap bb bb2
  print $ (show o)
