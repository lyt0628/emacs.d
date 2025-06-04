-- :PROPERTIES:
-- :ID:       4334eb98-39c0-41e7-9f72-d27148d1f4bd
-- :header-args: :tangle hs/Quadratic.hs :comments both
-- :END:
-- #+title: hs/util/quadratic
module Quadratic where


-- 求解 多项式，返回 n个解. 
-- [[file:../20250520114251-hs_util_quadrati_equation.org::+BEGIN_SRC haskell][No heading:1]]
newtype Quadratic a = Quadratic {
  slove :: [a] -> [a]
  }
-- No heading:1 ends here


main = do
  print $ "ok"
