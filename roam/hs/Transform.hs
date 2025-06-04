-- :PROPERTIES:
-- :ID:       1a38d4af-e192-42bf-a67b-3ce9354aaa1c
-- :header-args: :tangle hs/Transform.hs :comments both
-- :END:
-- #+title: cg/transform/hs


-- [[file:../20250517170011-cg_transform_hs.org::+BEGIN_SRC haskell][No heading:1]]
{-# LANGUAGE TypeFamilies #-}
module Transform(
  Transform2D, Transform3D
  ,transform2f, transform2d, transform3f, transform3d
  ) where
import Matrix
import Vector
import Point
import Epsilon
import Data.Kind (Type)
-- No heading:1 ends here


-- 我们不导出 Trnasform 的构造子.我们希望用户仅传入变换矩阵.
-- 但是构造子同时需要 变换矩阵和他的逆矩阵, 因此我们得额外定义构造器.


-- [[file:../20250517170011-cg_transform_hs.org::+BEGIN_SRC haskell][No heading:2]]
data Transform2D a = Transform2D (Mat3D a) (Maybe (Mat3D a)) deriving(Eq, Show)
data Transform3D a = Transform3D (Mat4D a) (Maybe (Mat4D a)) deriving(Eq, Show)
-- No heading:2 ends here

-- Trnasform 的聪明构造器


-- [[file:../20250517170011-cg_transform_hs.org::*Trnasform 的聪明构造器][Trnasform 的聪明构造器:1]]
transform2D :: (Floating a, Epsilon a) => Mat3D a -> Transform2D a  
transform2D mat3D = Transform2D mat3D (inverse mat3D)
transform3D :: (Floating a, Epsilon a) => Mat4D a -> Transform3D a  
transform3D mat4D = Transform3D mat4D (inverse mat4D)
-- Trnasform 的聪明构造器:1 ends here



-- 最后我们实现类型特化的聪明构造器和别名.
-- 这里的精度类型不包括 Integer， 这个精度对变换没有意义.

-- [[file:../20250517170011-cg_transform_hs.org::*Trnasform 的聪明构造器][Trnasform 的聪明构造器:2]]
type Transform2f = Transform2D Float
transform2f :: Mat3f -> Transform2f
transform2f = transform2D
type Transform2d = Transform2D Double
transform2d :: Mat3d -> Transform2d
transform2d = transform2D

type Transform3f = Transform3D Float
transform3f :: Mat4f -> Transform3f
transform3f = transform3D
type Transform3d = Transform3D Double
transform3d ::  Mat4d-> Transform3d
transform3d = transform3D
-- Trnasform 的聪明构造器:2 ends here

-- Operations
-- 即便是方阵也不一定可逆，当且仅当 det 不为0 时候 可逆.

-- [[file:../20250517170011-cg_transform_hs.org::*Operations][Operations:1]]
class TransformOps m where
  type VecND m a :: Type
  type PointND m a :: Type

  translate :: (Floating a, Epsilon a) => VecND m a -> m a 
  scale :: (Floating a, Epsilon a) => VecND m a -> m a
  scaling ::(Floating a, Epsilon a)=> m a -> Bool
  rotate :: (Floating a, Epsilon a) => a -> VecND m a -> m a
  changingChirality :: (Floating a, Epsilon a) =>m a -> Bool
-- Operations:1 ends here

-- Transform2D
-- 2D 过程变换细节详见, [[id:e359fd7c-717f-44ef-b10b-e192e1f8f3d5][cg/2d_transform]].


-- [[file:../20250517170011-cg_transform_hs.org::*Transform2D][Transform2D:1]]
instance TransformOps Transform2D where
  type VecND Transform2D a = Vec2D a
  type PointND Transform2D a = Point2D a
  translate (Vec2D x y) = Transform2D
    (Mat3D
     1 0 x
     0 1 y
     0 0 1)
    (Just (Mat3D
           1 0 (-x)
           0 1 (-y)
           0 0 1))

  scale (Vec2D x y) = Transform2D
    (Mat3D
     x 0 0
     0 y 0
     0 0 1)
    (Just (Mat3D
           (1/x) 0 0
           0 (1/y) 0
           0 0 1))

  scaling _ = False
-- Transform2D:1 ends here

-- [[file:../20250517170011-cg_transform_hs.org::*Transform2D][Transform2D:2]]
--
  rotate angle (Vec2D x y) =  transform2D (Mat3D
                                            (cos angle) (-(sin angle)) (x * (1 - cos angle) + y * sin angle) 
                                            (sin angle) (cos angle) (y * (1 - cos angle) - x * sin angle)
                                            0           0              1)
-- Transform2D:2 ends here

-- 偏手性
-- 判断变换是否改变偏手性，我们只需要看变换矩阵行列式的值是否为负.

-- [[file:../20250517170011-cg_transform_hs.org::*偏手性][偏手性:1]]
--
  changingChirality (Transform2D mat3D _) = det mat3D < 0
-- 偏手性:1 ends here

main = do
  print $ "ok"
