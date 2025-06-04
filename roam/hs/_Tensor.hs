-- :PROPERTIES:
-- :ID:       7a12fb92-dd45-4176-9983-0e39df8d396c
-- :header-args: :tangle hs/_Tensor.hs :comments both
-- :END:
-- #+title: linear/tensor/haskell~
-- #+LATEX_HEADER \usepackage{amsmath}

-- This impletement define all dimensions tensor as single class,
-- and not specify dimensions in runtime.
-- Haskell is a type static langugage, not a duck.
-- We can define tensor more strict.


-- [[file:../20250513181128-linear_tensor_haskell.org::+BEGIN_SRC haskell][No heading:1]]
module Tensor (
  Tensor(..)
  ,scalar,vector,matrix
  ,reshape
  ,transposeTensor
  ,tensorProduct
  ,contract
  )where
-- No heading:1 ends here



-- Tensor 类型：存储形状 (shape) 和扁平化的数据 (values)

-- [[file:../20250513181128-linear_tensor_haskell.org::+BEGIN_SRC haskell][No heading:2]]
data Tensor a = Tensor {
  shape :: [Int] 
  , values :: [a]
  } deriving(Eq, Show)
-- No heading:2 ends here



-- - 各维度大小，例如 [2,3] 表示 2x3 矩阵
-- - 元素按行优先顺序存储，例如矩阵 [[1,2],[3,4]] 存储为 [1,2,3,4]


-- [[file:../20250513181128-linear_tensor_haskell.org::+BEGIN_SRC haskell][No heading:3]]
scalar :: a -> Tensor a
scalar x = Tensor [] [x]
-- No heading:3 ends here

-- [[file:../20250513181128-linear_tensor_haskell.org::+BEGIN_SRC haskell][No heading:4]]
vector :: [a] -> Tensor a
vector xs = Tensor [length xs] xs
-- No heading:4 ends here

-- [[file:../20250513181128-linear_tensor_haskell.org::+BEGIN_SRC haskell][No heading:5]]
matrix :: [[a]] -> Tensor a
matrix xss
  | all (== cols) (map length xss) = Tensor [rows, cols] (concat xss)
  | otherwise = error "Inconsistent row length of matrix!"
  where
    rows = length xss
    cols = if null xss then 0 else length (head xss)
-- No heading:5 ends here



-- 张量加法, 逐元素加法

-- [[file:../20250513181128-linear_tensor_haskell.org::+BEGIN_SRC haskell][No heading:6]]
add :: Num a => Tensor a -> Tensor a -> Tensor a
add t1 t2
  | shape t1 /= shape t2 = error "Shape of tensors mismatch!"
  | otherwise = Tensor (shape t1) (zipWith (+) (values t1) (values t2))
-- No heading:6 ends here



-- 外积(张量积)

-- [[file:../20250513181128-linear_tensor_haskell.org::+BEGIN_SRC haskell][No heading:7]]
tensorProduct :: Num a => Tensor a -> Tensor a -> Tensor a
tensorProduct t1 t2 = Tensor (shape t1 ++ shape t2) [x * y | x <- values t1, y <- values t2]
-- No heading:7 ends here


-- - 张量积的结果维度为原维度之和.
-- - 张量积的元素为原本维度的两两组合，这里使用迭代器语法来生成组合

-- 对列表元素转置

-- [[file:../20250513181128-linear_tensor_haskell.org::+BEGIN_SRC haskell][No heading:8]]
transpose :: [[a]] -> [[a]]
transpose [] = []
transpose ([] : xss) = transpose xss  -- 跳过空行
transpose ((x : xs) : xss) =
  (x : [h | (h : _) <- xss]) :  -- 取出所有行的第一个元素
  transpose (xs : [t | (_ : t) <- xss])  -- 处理剩余元素
-- No heading:8 ends here


-- 我们的做法是，取出所有行的第一个元素，组成一列，然后递归，
-- 取出第二行的元素，组成第二列...
-- 1. 递归终止条件‌：
-- - 输入为空列表时返回空。
-- - 遇到空行 ([] : xss) 时跳过，继续处理后续行。
--   输入的列表，解构为 头部 [] 空列表，和剩下的元素. 如果匹配上了这个模式，
--   就直接转置剩下的元素

-- ‌2. 提取当前列‌：
-- - 使用列表推导 [h | (h : _) <- xss] 取出每行的第一个元素.
--   ,: 运算符‌：表示列表的头部 (h) 和尾部 (_)，例如 [1, 2, 3] 可分解为 1 : [2, 3]
--    (h : _)‌：匹配一个 ‌非空列表‌，提取第一个元素（头部）为 h，并忽略剩余元素（尾部用 _ 表示）
   
-- ‌3. 处理剩余元素‌：
-- - 对每行的剩余部分 (xs 和 t) 递归调用 transpose


-- [[file:../20250513181128-linear_tensor_haskell.org::+BEGIN_SRC haskell][No heading:9]]
transposeTensor :: Tensor a -> Tensor a
transposeTensor t
  | length (shape t) < 2 = t  -- 标量或向量无需转置
  | otherwise = Tensor newShape (concat $ transpose chunks)
  where
    -- 将数据分块为最内层维度
    chunkSize = last (shape t)
    chunks = chunksOf chunkSize (values t)
    -- 交换最后两个维度
    newShape = init (init (shape t)) ++ [last (shape t)] ++ [shape t !! (length (shape t) - 2)]
-- No heading:9 ends here



-- - 这两个交换维度是随便选定的，哪两个都行.
-- - init (shape t)‌
--   提取原形状列表 ‌除最后一个元素外的所有元素‌。两个 init 就去除了最后两个元素
--   例如：若 shape t = [2, 3, 4]，则 init (shape t) = [2, 3]。

-- - ‌[last (shape t)]‌
--   提取原形状的 ‌最后一个元素‌，并包装成单元素列表。
--   例如：last (shape t) = 4 → [4]。

-- ‌- shape t !! (length (shape t) - 2)‌
-- !! 是索引操作符号, 相当于其他语言的 []
-- 提取原形状的 ‌倒数第二个元素‌（索引从 0 开始）。
-- 例如：shape t = [2, 3, 4]，则 length (shape t) - 2 = 1 → shape t !! 1 = 3。

-- 这里的 init 和 last，可以类系 Lisp 的 构造子列表 car 和 cdr.
-- 不过它们在构造方向上是相反的.



-- [[file:../20250513181128-linear_tensor_haskell.org::+BEGIN_SRC haskell][No heading:10]]
reshape :: [Int] -> Tensor a -> Tensor a
reshape newShape t
  | product newShape == product (shape t) = Tensor newShape (values t)
  | otherwise = error "新形状元素总数不匹配"
-- No heading:10 ends here

-- Contract(收缩)

-- [[file:../20250513181128-linear_tensor_haskell.org::*Contract(收缩)][Contract(收缩):1]]
-- 张量收缩（例如矩阵乘法）
-- 参数：收缩 t1 的第 k 个轴和 t2 的第 l 个轴
contract :: Num a => Int -> Int -> Tensor a -> Tensor a -> Tensor a
contract k l t1 t2
  | s1 !! k /= s2 !! l = error "收缩维度长度不匹配"
  | otherwise = Tensor newShape [sumProd xs ys | xs <- groupedT1, ys <- groupedT2]
  where
    s1 = shape t1
    s2 = shape t2
    -- 计算新形状
    newShape = removeAt k s1 ++ removeAt l s2
    -- 分组待收缩维度
    groupedT1 = groupAxes k t1
    groupedT2 = groupAxes l t2
    -- 计算对应组的点积和
    sumProd xs ys = sum $ zipWith (*) xs ys

-- ======================
--       内部工具函数
-- ======================

-- 按指定轴分组数据（用于收缩）
groupAxes :: Int -> Tensor a -> [[a]]
groupAxes axis t = chunksOf chunkSize grouped
  where
    s = shape t
    axisSize = s !! axis
    -- 计算其他维度的总长度
    outerDims = product (removeAt axis s)
    -- 每个组的元素数量为轴的大小
    chunkSize = axisSize
    -- 将轴移动到末尾并分组
    permutedIndices = permutation axis (length s)
    rearranged = transpose (chunksOf (product (drop (axis + 1) s)) (values t))
    grouped = concat rearranged

-- 生成调整维度的排列（将指定轴移到最后）
permutation :: Int -> Int -> [Int]
permutation axis n = [0..axis-1] ++ [axis+1..n-1] ++ [axis]

-- 辅助函数：从列表中移除指定位置元素
removeAt :: Int -> [a] -> [a]
removeAt idx xs = take idx xs ++ drop (idx + 1) xs

-- 将列表分割成大小为 n 的子列表
chunksOf :: Int -> [a] -> [[a]]
chunksOf _ [] = []
chunksOf n xs = take n xs : chunksOf n (drop n xs)
-- Contract(收缩):1 ends here
