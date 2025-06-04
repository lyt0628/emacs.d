-- :PROPERTIES:
-- :ID:       9715178a-22c5-4229-98d1-6502630477a8
-- :header-args: :tangle hs/Sphere.hs :comments both
-- :END:
-- #+title: cg/sphere/hs


-- [[file:../20250518233919-cg_sphere.org::+BEGIN_SRC haskell][No heading:1]]
{-# LANGUAGE TypeFamilies #-}
module Sphere where
import qualified Point as P
import qualified Vector as V
import qualified Matrix as M
import qualified Ray as R
import qualified Polynomial as Poly
-- No heading:1 ends here



-- 在形状这一方面，我们就无需对维度参数化了，我们考虑的图形，不会抽象到维度泛化.
-- 我们使用球的参数方程描述球.


-- [[file:../20250518233919-cg_sphere.org::+BEGIN_SRC haskell][No heading:2]]
data Sphere a = Sphere {
  radius :: a -- 半径
  ,thetaMin :: a
  ,thetaMax :: a -- 方位角
  ,phiMax :: a -- 极角
  } deriving(Eq, Show)
-- No heading:2 ends here

-- Ray-Sphere Intersection
-- 我们已经很清楚标准方程的求交了.

-- [[file:../20250518233919-cg_sphere.org::*Ray-Sphere Intersection][Ray-Sphere Intersection:1]]
instance R.RayIntersect Sphere where
  type RayND Sphere a = R.Ray3D a 
  type PointND Sphere a = P.Point3D a
  intersectP _ _ = False
  intersect (R.Ray3D (P.Point3D ox oy oz) (V.Vec3D dx dy dz) tMax) (Sphere r thetaMin thetaMax phiMax)=
-- Ray-Sphere Intersection:1 ends here


-- 首先，我们计算出标准求根的 三个二次方程系数.

-- [[file:../20250518233919-cg_sphere.org::*Ray-Sphere Intersection][Ray-Sphere Intersection:2]]
----
    let a = (dx^2 + dy^2 + dz^2)
        b = 2 * (ox * dx + oy * dy + oz *dz)
        c = (ox^2 + oy^2 + oz^2) - r * r
        
-- Ray-Sphere Intersection:2 ends here
    in Nothing

main = do
  print "ok"
