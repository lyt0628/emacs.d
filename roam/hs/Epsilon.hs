-- :PROPERTIES:
-- :ID:       bff78784-4367-4246-85a2-02e8d71b2e79
-- :header-args: :tangle hs/Epsilon.hs :comments both
-- :END:
-- #+title: haskell/epsilon

-- [[file:../20250514142901-haskell_epsilon.org::+BEGIN_SRC haskell][No heading:1]]
module Epsilon (
    Epsilon(epsilon, nearZero)  -- 仅导出类型类和方法
) where
-- No heading:1 ends here

-- [[file:../20250514142901-haskell_epsilon.org::+BEGIN_SRC haskell][No heading:2]]
class (Num a, Ord a) => Epsilon a where
    epsilon :: a
    nearZero :: a -> Bool  -- 必须由每个实例显式实现

-- ========================
-- 实例定义（手动实现所有方法）
-- ========================
instance Epsilon Float where
    epsilon = 1.1920929e-7
    nearZero x = abs x < epsilon  -- 显式实现逻辑

instance Epsilon Double where
    epsilon = 2.220446049250313e-16
    nearZero x = abs x < epsilon  -- 显式实现逻辑
-- No heading:2 ends here
