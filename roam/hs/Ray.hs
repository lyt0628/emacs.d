-- :PROPERTIES:
-- :ID:       ac451ee7-80e6-440e-9c99-1efe90dc7b73
-- :header-args: :tangle hs/Ray.hs :comments both
-- :END:
-- #+title: cg/ray/hs


-- [[file:../20250515002822-cg_ray_haskell.org::+BEGIN_SRC haskell][No heading:1]]
{-# LANGUAGE TypeFamilies #-}
module Ray(
  Ray3D(..)
  ,RayIntersect(..)
  ,Ray2f, Ray2d, Ray3f, Ray3d
  ,ray2f, ray2d, ray3f, ray3d
  ) where
import Vector
import Point
import Data.Kind (Type)
import Epsilon
-- No heading:1 ends here

-- [[file:../20250515002822-cg_ray_haskell.org::+BEGIN_SRC haskell][No heading:2]]
data Ray2D a = Ray2D (Point2D a) (Vec2D a) a deriving(Eq,Show) 
data Ray3D a = Ray3D (Point3D a) (Vec3D a) a deriving(Eq,Show)

type Ray2f = Ray2D Float
ray2f :: Float -> Float -> Float -> Float -> Float -> Ray2f
ray2f x y dx dy tMax= Ray2D (Point2D x y) (Vec2D dx dy) tMax

type Ray2d = Ray2D Double
ray2d :: Double -> Double -> Double -> Double -> Double -> Ray2d
ray2d x y dx dy tMax= Ray2D (Point2D x y) (Vec2D dx dy) tMax

type Ray3f = Ray3D Float
ray3f :: Float -> Float -> Float -> Float -> Float -> Float -> Float -> Ray3f
ray3f x y z dx dy dz tMax = Ray3D (Point3D x y z) (Vec3D dx dy dz) tMax

type Ray3d = Ray3D Double
ray3d :: Double -> Double -> Double -> Double -> Double -> Double -> Double -> Ray3d
ray3d x y z dx dy dz tMax= Ray3D (Point3D x y z) (Vec3D dx dy dz) tMax
-- No heading:2 ends here


-- Ray contains a origin and a direction.
-- Ray is semi-infine line.

-- The data stored in a ray is

--   @startuml
--   struct RayND<a>{
--           origin : PointND,
--           dir : VecND,
--   }
--   @enduml
  



-- Lets define typeclass for Ray.
-- First, we associate correspond Point and Vec for Ray.
-- And define a sample function, given a value [0, 1],
-- sample will return a point that interport in the ray.

-- 在 OOP 中，有人会把 t 定义在 RayND 中作为状态, 但这在 函数式 编程中并不可行.
-- 状态和其他的一切必须显示分离.

-- 在 CG 中，时间是关键的环境因素,给定时间内，我们的物体处在一个固定的状态.
-- 但时间是状态，必须显示隔离, 我们不能将它定义在 射线 数据里面，我们这里仅仅表达数学上的射线，


-- 因此Ray 的定义就十分简单了，我们只让他包含基本定义数据. 此外的
-- Ray 不是容器，不适合定义成函子.

-- 此外我们定义 类型类来表示与射线相交测试这一操作, 由具体的形状类去实现.

-- [[file:../20250515002822-cg_ray_haskell.org::+BEGIN_SRC haskell][No heading:3]]
class RayIntersect o where
    type RayND o a :: Type
    type PointND o a :: Type
--    type PointND o a :: Type
    intersectP :: (Floating a, Epsilon a) =>RayND o a -> o a -> Bool
    intersect ::(Floating a, Epsilon a) => RayND o a -> o a -> Maybe (a, PointND o a)
-- No heading:3 ends here
