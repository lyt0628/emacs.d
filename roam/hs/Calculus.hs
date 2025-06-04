-- :PROPERTIES:
-- :ID:       00776d7e-ecc4-472e-8e31-6f7f776eb2e2
-- :header-args: :tangle hs/Calculus.hs :comments both :mkdirp t
-- :END:
-- #+title: calculus/hs

-- 用Haskell 实现 微积分的计算.

-- [[file:../20250521183216-calculus_hs.org::+BEGIN_SRC haskell][No heading:1]]
module Calculus where
-- No heading:1 ends here

-- 表达式抽象

-- [[file:../20250521183216-calculus_hs.org::*表达式抽象][表达式抽象:1]]
type Symbol = String 
data Expr a = Constant a
            | Var Symbol
            | Add (Expr a) (Expr a)
            | Mul (Expr a) (Expr a)
            deriving(Show)
-- 表达式抽象:1 ends here

-- 微分计算

-- [[file:../20250521183216-calculus_hs.org::*微分计算][微分计算:1]]
class  Differentiable a where
  symDiff :: Symbol -> a -> a
  numDiff :: Symbol -> b -> b -> a -> a
  eval ::[(Symbol, b, b)] -> a -> b
-- 微分计算:1 ends here



-- - symDiff, 符号微分，返回微分函数的表达式
-- - numDiff, 数值微分，根据符号的指定位置和步长, 然后返回对应的微分表达式
-- - eval, 对一个表达式求值, 前面的列表指定了表达式的值. 最后一个远组元素指定差分步长.



-- [[file:../20250521183216-calculus_hs.org::*微分计算][微分计算:2]]
instance Num a => Differentiable (Expr a) where
  symDiff _ (Constant _)   = Constant 0
  numDiff = undefined
  eval = undefined
-- 微分计算:2 ends here
