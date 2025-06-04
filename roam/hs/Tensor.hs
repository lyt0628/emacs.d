-- :PROPERTIES:
-- :ID:       d8dd6b68-74ea-4fd5-806d-9330e15c73b9
-- :header-args: :tangle hs/Tensor.hs :comments both
-- :END:
-- #+title: linear/tensor/haskell


-- [[file:../20250516164348-linear_tensor_haskell.org::+BEGIN_SRC haskell][No heading:1]]
module Tensor(
  Tensor(..)
  ,scalar, vector, matrix
  ,transpose, reshape
  ) where
import qualified Data.List as L
-- No heading:1 ends here

-- [[file:../20250516164348-linear_tensor_haskell.org::+BEGIN_SRC haskell][No heading:2]]
data Tensor a where
  Scalar :: a -> Tensor a
  Tensor :: [Int] -> [a] -> Tensor a
-- No heading:2 ends here



-- 这是我觉得最合适的张量定义.
-- 首先，标量作为原始类型直接储存值，我们可以靠Scalar 构造子来模式匹配标量.
-- 然后其他的高纬张量有自己的构造子.
-- 它符合我们对张量的看法，标量作为原始类型，然后进行推广，称为向量，矩阵，以及其他更高纬的张量.

-- 相比与 [[id:baaaadb4-33b1-4fd4-9ef9-8808113db59d][TypeList XTensor]], 它没有类型级的形状安全，但是更灵活了一点，实现起来也简单多了.
-- 相比与 [[id:7a12fb92-dd45-4176-9983-0e39df8d396c][linear/tensor/haskell-1]], 它把原始类型和推广类型分开了，更符合数学世界的概念.


-- 下面实现了一些常用维度的构造子，帮我们自动从常用的形状构造张量.
-- 只定义了低纬的几个，更高维度的不如直接指定形状来构造方便.

-- [[file:../20250516164348-linear_tensor_haskell.org::+BEGIN_SRC haskell][No heading:3]]
deriving instance Eq a => Eq (Tensor a)
deriving instance Show a => Show (Tensor a)

scalar :: a -> Tensor a
scalar = Scalar

vector :: [a] -> Tensor a
vector xs = Tensor [length xs] xs

matrix :: [[a]] -> Tensor a
matrix xss
  | all (== cols) (map length xss) = Tensor [rows, cols] (concat xss)
  | otherwise = error "Inconsistent row length of matrix!"
  where
    rows = length xss
    cols = if null xss then 0 else length (head xss)
-- No heading:3 ends here

-- 定义张量为函子和应用函子
-- 张量适合定义为函子，我们可以轻松实现按位的单目运算. 例如 取反，+3.

-- [[file:../20250516164348-linear_tensor_haskell.org::*定义张量为函子和应用函子][定义张量为函子和应用函子:1]]
instance Functor Tensor where
  fmap f (Scalar x) = Scalar (f x)
  fmap f (Tensor s xs) = Tensor s (map f xs)
-- 定义张量为函子和应用函子:1 ends here



-- 张量定义为应用函子，用于 张量间的按位 四则运算.

-- [[file:../20250516164348-linear_tensor_haskell.org::*定义张量为函子和应用函子][定义张量为函子和应用函子:2]]
instance Applicative Tensor where
  pure = Scalar

  liftA2 f (Scalar x) (Scalar y) = Scalar (f x y)
  liftA2 f (Scalar x) (Tensor s ys) = Tensor s (map (f x) ys)
  liftA2 f (Tensor s xs) (Scalar y) = Tensor s (map (flip f y) xs)

  liftA2 f (Tensor s1 xs) (Tensor s2 ys) =
    let s = boardcastShape s1 s2
        (xs', ys') = expandTensors s1 xs s2 ys s
    in Tensor s (zipWith f xs' ys')

  (<*>) (Scalar f) (Scalar x) = Scalar (f x)
  (<*>) (Scalar f) (Tensor s xs) = Tensor s (map f xs)
  (<*>) (Tensor s1 fs) (Tensor s2 xs) =
    let s = boardcastShape s1 s2
        (fs', xs') = expandTensors s1 fs s2 xs s
    in Tensor s (zipWith ($) fs' xs')
-- 定义张量为函子和应用函子:2 ends here



-- 注意 这里在处理 应用的时候，当左值为张量，我们还是要先应用标量类型，但为了保证运算顺序,
-- 我们使用 flip 来反转参数列表的方向.

-- 下面是一些执行广播时候的帮助函数.

-- 这个函数用于确定广播形状.按照以下规则:
-- 1. 在某个维度上，
--    如果两个张量长度相同，则保持原值.
--    如果其中一个张量长度为1，则广播为另一个张量的长度.
-- 2. 如果在某个维度上，张量长度不同，其长度又都不为 1,则不可广播.

-- [[file:../20250516164348-linear_tensor_haskell.org::*定义张量为函子和应用函子][定义张量为函子和应用函子:3]]
boardcastShape :: [Int] -> [Int] -> [Int]
boardcastShape [] [] = []
boardcastShape [] ys = ys
boardcastShape xs [] = xs
boardcastShape (x:xs) (y:ys)
  | x == y = x : boardcastShape xs ys
  | x == 1 = y : boardcastShape xs ys
  | y == 1 = x : boardcastShape xs ys
  | otherwise = error "Shape ar not compatible for boardcasting"
-- 定义张量为函子和应用函子:3 ends here

-- [[file:../20250516164348-linear_tensor_haskell.org::*定义张量为函子和应用函子][定义张量为函子和应用函子:4]]
expandTensors :: [Int] -> [a] -> [Int] -> [b] -> [Int] -> ([a], [b])
expandTensors s1 xs s2 ys s =
  let nrepeatx = [ if sh1 == 1 then sh2 else 1 | (sh1, sh2) <- zip s1 s]
      nrepeaty = [ if sh2 == 1 then sh1 else 1 | (sh1, sh2) <- zip s2 s]

      nrepeatx' = product nrepeatx
      nrepeaty' = product nrepeaty

      expandedx = concat $ replicate nrepeatx' xs
      expandedy = concat $ replicate nrepeaty' ys

  in (expandedx, expandedy)
-- 定义张量为函子和应用函子:4 ends here

-- 张量操作


-- [[file:../20250516164348-linear_tensor_haskell.org::*张量操作][张量操作:1]]
class TensorOps t where
  transpose :: t -> t
  reshape :: [Int] -> t -> t
-- 张量操作:1 ends here

-- 转置

-- [[file:../20250516164348-linear_tensor_haskell.org::*转置][转置:1]]
instance TensorOps (Tensor a) where
  transpose (Scalar s) = Scalar s
  transpose (Tensor s xs)
    | length s < 2 = Tensor s xs  -- 标量或向量无需转置
    | otherwise = Tensor newShape (concat $ L.transpose chunks)
    where
      -- 将数据分块为最内层维度
      chunkSize = last s
      chunks = chunksOf chunkSize xs
      -- 交换最后两个维度
      newShape = init (init s) ++ [last s] ++ [s !! (length s - 2)]
-- 转置:1 ends here

-- 改变张量形状

-- [[file:../20250516164348-linear_tensor_haskell.org::*改变张量形状][改变张量形状:1]]
-- For Indent
  reshape s' (Scalar s)
    | (length s') == 1 = Scalar s
    | otherwise = error "新形状元素总数不匹配"
  reshape s' (Tensor s xs)
    | product s' == product s = Tensor s' xs
    | otherwise = error "新形状元素总数不匹配"
-- 改变张量形状:1 ends here

-- 张量收缩

-- 帮助函数 <<chunksOf>>

-- [[file:../20250516164348-linear_tensor_haskell.org::chunksOf][张量收缩:1]]
chunksOf :: Int -> [a] -> [[a]]
chunksOf _ [] = []
chunksOf n xs = take n xs : chunksOf n (drop n xs)
-- 张量收缩:1 ends here
