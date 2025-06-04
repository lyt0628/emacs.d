-- :PROPERTIES:
-- :ID:       baaaadb4-33b1-4fd4-9ef9-8808113db59d
-- :header-args: :tangle hs/XTensor.hs :comments both
-- :END:
-- #+title: linear/tensor/haskell


-- [[file:../20250515105602-linear_tensor_haskell.org::+BEGIN_SRC haskell][No heading:1]]
{-# LANGUAGE TypeFamilies, DataKinds, GADTs, KindSignatures #-}
{-# LANGUAGE FlexibleInstances, MultiParamTypeClasses #-}

module XTensor where

import Data.Kind (Type)
import GHC.TypeLits (Nat, KnownNat, natVal)
import Data.Proxy (Proxy(..))
-- No heading:1 ends here



-- we want a static type check.
-- All operations is required with a proper dimensions.

-- So, First thing to do is define demensions as a type.


-- [[file:../20250515105602-linear_tensor_haskell.org::+BEGIN_SRC haskell][No heading:2]]
class TensorShape (dims :: [Nat]) where
  type DimShape dims :: [Nat]
  shape :: Proxy dims -> [Nat]
-- No heading:2 ends here



-- TensorShape 是一个类型类，它定义在 自然数列表 组成的类型中.
-- 这里 [Nat] 处于类型声明的位置，表明它是类型级别的List.
-- 然后使用 type 定义一个关联类型, 它对于 具体类型 dims 就是他的 列表类型 [Nat]
-- shape 是一个函数,接收 携带类型参数 dims 的 Proxy 类型实例，返回它的 类型级别信息 dims. 
-- 当我们想获取类型级别信息时候，首先将类型作为类型参数，传递给 Proxy 类型，在用 相应的 类型参数访问器
-- 这里是shape，拿到类型级别信息.

-- the TensorDims class with a type paramater dims,
-- which is a nature number.

-- and associate to a Type DimShape that is the shape of tensor, which is defined in Type Level.
-- But we want to get shape for a specific instance.
-- so we have to define a instance function shape,
-- that will return the shape that stored in correspons type.

-- '[] is a empty Tensor, whose shape is alway
-- a empty List.

-- [[file:../20250515105602-linear_tensor_haskell.org::+BEGIN_SRC haskell][No heading:3]]
instance TensorShape '[] where
  type DimShape '[] = '[]
  shape _ = []
-- No heading:3 ends here



-- In Haskell '[] is a special List, which can serve as a type. But it still a List.
-- For telling two concept, whe  '[] work as a type, we call it ListType. when '[]
-- work as List, we use symbol.
-- '[] is a list without value, whcich is represent the shape of scalar. 


-- [[file:../20250515105602-linear_tensor_haskell.org::+BEGIN_SRC haskell][No heading:4]]
instance (KnownNat n, TensorShape rest) => TensorShape (n ': rest) where
  type DimShape (n ': rest) = n ': DimShape rest
  shape _ = fromIntegral (natVal (Proxy @n)) : shape (Proxy @rest)
-- No heading:4 ends here



-- Finally we can define a Tensor type, which is GADT.
-- In primitive source, that is 0-dimensiton, tensor just a scalar a with '[] Empty TypeList as Shape.
-- In Promotion, Tensor is a generic List as parameters that will reviced by
-- parameters that defined in a type-level.

-- [[file:../20250515105602-linear_tensor_haskell.org::+BEGIN_SRC haskell][No heading:7]]
data Tensor (dims :: [Nat]) a where
  Scalar :: a -> Tensor '[] a
  Tensor :: TensorShape dims => [a] -> Tensor dims a
-- No heading:7 ends here


-- Tensor 是GADT 广义数据结构，它允许类型参数(类型实例声明)的值影响构造子，
-- 具体体现为 Tensor 构造子
-- TensorShape 模式匹配，不执行结构 dims 是类型级别的 定义 (dims :: [Nat]).
-- 相当于对于每个 可能的 [Nat] 类型列表的类型实例 都有 该实例的一个 Tensor构造.
-- 而Tensor的值级别参数（Tensor数据类的数据）是 [a] 值级别数组.这符合我们的抽象.
-- 对于一个 List [a] 在不同形状的张量下，应当是不同的类型.

-- 在这里 Tensor 满足这么一个代数构造，
-- 对于原始情况，Tensor 为一个 标量 a， 张量类型 为 空的类型列表.
-- 对于推广情况，当实例的类型声明为

-- As a data type, the paramater of constructor is their values.
-- In Scalar case, a is the value,
-- In Tensor case, [a] is the value.
-- It meets our concept, scalar is not a List, but those dimension above one are.


-- Casuse using GADT, we have to define veriving standalonely.

-- [[file:../20250515105602-linear_tensor_haskell.org::+BEGIN_SRC haskell][No heading:8]]
deriving instance Eq a => Eq (Tensor dims a)
deriving instance Show a => Show (Tensor dims a)
-- No heading:8 ends here



-- 这里是一些常用的特化张量类型，我们固化了他的构造子.
-- And, define some healper constructor for domain-specific usecase.

-- [[file:../20250515105602-linear_tensor_haskell.org::+BEGIN_SRC haskell][No heading:9]]
scalar :: a -> Tensor '[] a
scalar = Scalar

vector :: KnownNat n => [a] -> Tensor '[n] a
vector xs = Tensor xs

matrix :: (KnownNat m, KnownNat n) => [[a]] -> Tensor '[m, n] a
matrix xss = Tensor (concat xss)
-- No heading:9 ends here



-- KnownNat is a type contrant thet means a Nature that can be known by Haskell in compile time.

-- Now we can define tensor operation with type safe.

-- [[file:../20250515105602-linear_tensor_haskell.org::+BEGIN_SRC haskell][No heading:10]]
class TensorAdd t where
  add :: t -> t -> t

instance Num a => TensorAdd (Tensor dims a) where
  add (Tensor xs) (Tensor ys) = Tensor (zipWith (+) xs ys)
  add (Scalar x) (Scalar y) = Scalar (x + y)
-- No heading:10 ends here
