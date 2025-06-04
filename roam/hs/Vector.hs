-- :PROPERTIES:
-- :ID:       56824b46-bbb5-4356-bbb4-a3a57538bc13
-- :header-args: :tangle hs/Vector.hs :comments both :mkdirp t
-- :END:
-- #+title: cg/vector/hs

-- Notice it just a note. i use this code to
-- enhance the abstract concept. A good notes with a lot of
-- links of differenr fields.

-- I should make the code generic for various usecase, instead of
-- make specific version for each fields.
-- This is fine for project, not for brain and learning.


-- [[file:../20250514134512-linear_vector_haskell.org::+BEGIN_SRC haskell][No heading:1]]
module Vector (
  Vec2D(..), Vec3D(..), Vec4D(..)
  ,Vec2i,Vec2f,Vec2d,Vec3i,Vec3f,Vec3d,Vec4i,Vec4f,Vec4d
  ,vec2i,vec2f,vec2d,vec3i,vec3f,vec3d,vec4i,vec4f,vec4d
  , dot, mag, magSq ,norm
  , cross3  -- 3D特有的叉乘
  ) where
import Epsilon (Epsilon(..))
-- No heading:1 ends here



-- 我们这里使用的向量主要用于表示现实，因此定义的向量直接固化它的维度.
-- 这可以提供更好的类型安全检查.

-- [[file:../20250514134512-linear_vector_haskell.org::+BEGIN_SRC haskell][No heading:2]]
data Vec2D a = Vec2D a a deriving (Eq, Show, Functor)
data Vec3D a = Vec3D a a a deriving (Eq, Show, Functor)
data Vec4D a = Vec4D a a a a deriving (Eq, Show, Functor)
-- No heading:2 ends here



-- 我们提供一些类型别名, 表示哪些固定精度的类型.
-- 还有对构造子的方便调用. 我们还是把构造子暴露出去以支持模式匹配.

-- [[file:../20250514134512-linear_vector_haskell.org::+BEGIN_SRC haskell][No heading:3]]
type Vec2f = Vec2D Float
vec2f :: Float -> Float -> Vec2f
vec2f = Vec2D 
type Vec2d = Vec2D Double
vec2d :: Double -> Double -> Vec2d
vec2d = Vec2D
type Vec2i = Vec2D Integer
vec2i :: Integer -> Integer -> Vec2i
vec2i = Vec2D 

type Vec3f = Vec3D Float
vec3f :: Float -> Float -> Float -> Vec3f
vec3f = Vec3D
type Vec3d = Vec3D Double
vec3d :: Double -> Double -> Double -> Vec3d
vec3d = Vec3D
type Vec3i = Vec3D Integer
vec3i :: Integer -> Integer -> Integer -> Vec3i
vec3i = Vec3D

type Vec4f = Vec4D Float
vec4f :: Float -> Float -> Float -> Float -> Vec4f
vec4f = Vec4D
type Vec4d = Vec4D Double
vec4d :: Double -> Double -> Double -> Double -> Vec4d
vec4d = Vec4D
type Vec4i = Vec4D Integer
vec4i :: Integer -> Integer -> Integer -> Integer -> Vec4i
vec4i = Vec4D
-- No heading:3 ends here

-- [[file:../20250514134512-linear_vector_haskell.org::+BEGIN_SRC haskell][No heading:4]]
class VectorOps v where
--    add :: (Num a) => v a -> v a -> v a
--    sub :: (Num a) => v a -> v a -> v a
    dot :: (Num a) => v a -> v a -> a
--    scale :: (Num a) => a -> v a -> v a
    mag :: (Floating a) => v a -> a
    magSq :: (Floating a) => v a -> a
    norm :: (Floating a, Epsilon a) => v a -> Maybe (v a)
-- No heading:4 ends here



-- 我们使用 默认的派生来实现函子.

-- 我们把不同维度向量定义为不同类型，这使得我们需要做一些重复工作,
-- 但使得类型更加简单，更好理解.
-- 一个定义类型的原则是，不要定义出你不用的类型.
-- 我们的向量工作在 CG 中，它永远不会超过4维.
-- 如果定义为更加广泛的数据类型, 只会增加类型检查的难度.
-- 如果是在 机器学习中，你应当使用尽可能大的类型空间，你确实需要它, 但在 图形学中并不需要.


-- [[file:../20250514134512-linear_vector_haskell.org::+BEGIN_SRC haskell][No heading:6]]
instance VectorOps Vec2D where
--    add (Vec2D x1 y1) (Vec2D x2 y2) = Vec2D (x1+x2) (y1+y2)
--    sub (Vec2D x1 y1) (Vec2D x2 y2) = Vec2D (x1-x2) (y1-y2)
    dot (Vec2D x1 y1) (Vec2D x2 y2) = x1*x2 + y1*y2
--    scale s (Vec2D x y) = Vec2D (s*x) (s*y)
    mag(Vec2D x y) = sqrt (x^2 + y^2)
    magSq (Vec2D x y) = x^2 + y^2
    norm:: (Floating a, Epsilon a) => Vec2D a -> Maybe (Vec2D a)
    norm v = let m = mag v
                  in if nearZero m
                     then Nothing 
                     else Just $ (fmap (/m) v)
-- No heading:6 ends here


-- 我们用 instance 关键字实例化 class, 并制定了 Vec2D 作为接收者.
-- 区别与模式匹配，这种方式定义的函数是真的鸭子，而不仅仅是鸭子类型.


-- [[file:../20250514134512-linear_vector_haskell.org::+BEGIN_SRC haskell][No heading:7]]
instance VectorOps Vec3D where
--    add (Vec3D x1 y1 z1) (Vec3D x2 y2 z2) = Vec3D (x1+x2) (y1+y2) (z1+z2)
--    sub (Vec3D x1 y1 z1) (Vec3D x2 y2 z2) = Vec3D (x1-x2) (y1-y2) (z1-z2)
    dot (Vec3D x1 y1 z1) (Vec3D x2 y2 z2) = x1*x2 + y1*y2 + z1*z2
--    scale s (Vec3D x y z) = Vec3D (s*x) (s*y) (s*z)
    mag (Vec3D x y z) = sqrt (x^2 + y^2 + z^2)
    magSq (Vec3D x y z) = x^2 + y^2 + z^2
    norm:: (Floating a, Epsilon a) => Vec3D a -> Maybe (Vec3D a)
    norm v = let m = mag v
                  in if nearZero m
                     then Nothing 
                     else Just $ (fmap (/m) v)
-- No heading:7 ends here

-- [[file:../20250514134512-linear_vector_haskell.org::+BEGIN_SRC haskell][No heading:8]]
instance VectorOps Vec4D where
--    add (Vec4D x1 y1 z1 w1) (Vec4D x2 y2 z2 w2) = Vec4D (x1+x2) (y1+y2) (z1+z2) (w1+w2)
--    sub (Vec4D x1 y1 z1 w1) (Vec4D x2 y2 z2 w2) = Vec4D (x1-x2) (y1-y2) (z1-z2) (w1-w2)
    dot (Vec4D x1 y1 z1 w1) (Vec4D x2 y2 z2 w2) = x1*x2 + y1*y2 + z1*z2 + w1*w2
--    scale s (Vec4D x y z w) = Vec4D (s*x) (s*y) (s*z) (s*w)
    mag (Vec4D x y z w) = sqrt (x^2 + y^2 + z^2 + w^2)
    magSq (Vec4D x y z w) = x^2 + y^2 + z^2 + w^2
    norm:: (Floating a, Epsilon a) => Vec4D a -> Maybe (Vec4D a)
    norm v = let m = mag v
                  in if nearZero m
                     then Nothing 
                     else Just $ (fmap (/m) v)
-- No heading:8 ends here

-- [[file:../20250514134512-linear_vector_haskell.org::+BEGIN_SRC haskell][No heading:9]]
cross3 :: (Num a) => Vec3D a -> Vec3D a -> Vec3D a
cross3 (Vec3D x1 y1 z1) (Vec3D x2 y2 z2) = 
    Vec3D (y1*z2 - z1*y2) 
         (z1*x2 - x1*z2)
         (x1*y2 - y1*x2)
-- No heading:9 ends here
