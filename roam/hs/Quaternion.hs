-- :PROPERTIES:
-- :ID:       6d78a534-2786-4825-97d6-9bfd72086a7f
-- :header-args: :tangle hs/Quaternion.hs :comments both
-- :END:
-- #+title: cg/quaternion/hs


-- [[file:../20250518045949-cg_quaternion_hs.org::+BEGIN_SRC haskell][No heading:1]]
module Quaternion where
import qualified Vector as V
-- No heading:1 ends here


-- dot 和 向量点积重名，因此限定为V 来避免名称冲突.


-- [[file:../20250518045949-cg_quaternion_hs.org::+BEGIN_SRC haskell][No heading:2]]
data Quaternion a = Quaternion V.Vec3D a deriving(Eq,Show,Functor)
-- No heading:2 ends here


-- 我们使用 Vec3D 用来表示虚部，a 用于表示实部.

-- Quaternion 的四则运算也是分量运算, 因此可以定义为函子.

-- Quternion 是3D 范围的，不需要用到 GADT, 因此直接使用函数定义就好了.
-- 不需要使用类型类.



-- [[file:../20250518045949-cg_quaternion_hs.org::+BEGIN_SRC haskell][No heading:3]]
dot :: Num a => Quternion a -> Quternion a -> a
dot (Quaternion v1 w1) (Quaternion v2 w2)= (V.dot v1 v2) + w1*w2
-- No heading:3 ends here

-- [[file:../20250518045949-cg_quaternion_hs.org::+BEGIN_SRC haskell][No heading:4]]
norm :: Floating a => Quaternion a -> Quaternion a
norm q = (((/)(dot q q)) <$> q)
-- No heading:4 ends here

-- [[file:../20250518045949-cg_quaternion_hs.org::+BEGIN_SRC haskell][No heading:5]]
toTransform :: Quaternion a -> Transform3D a
-- No heading:5 ends here

-- [[file:../20250518045949-cg_quaternion_hs.org::+BEGIN_SRC haskell][No heading:6]]
slerp :: Floating a => a -> Quaternion a -> Quaternion -> Quaternion a
-- No heading:6 ends here
