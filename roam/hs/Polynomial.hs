-- :PROPERTIES:
-- :ID:       4334eb98-39c0-41e7-9f72-d27148d1f4bd
-- :header-args: :tangle hs/Polynomial.hs :comments both
-- :END:
-- #+title: hs/util/polynomainal



-- [[file:../20250520114251-hs_util_quadrati_equation.org::+BEGIN_SRC haskell][No heading:1]]
module Polynomial(
  Polynomial(..)
  ,quadratic, quadraticf
                 ) where
import Epsilon 

newtype Polynomial a = Polynomial {
  slove ::  [a]
  } deriving(Show, Eq)
-- No heading:1 ends here

-- 二项式解析法解决.

-- [[file:../20250520114251-hs_util_quadrati_equation.org::*二项式解析法解决.][二项式解析法解决.:1]]
quadratic :: (Floating a, Epsilon a) => a -> a -> a -> Either String (Polynomial a) 
quadratic a b c
  | nearZero a = Left "Cofficient a of quadratic item cannot be 0!"
  | discriminant < 0 = Right $ Polynomial []
  | discriminant == 0 = Right $ Polynomial [-(b/(2*a))]
  | otherwise = Right $ Polynomial  [(-b + sqrt discriminant)/ 2*a , (-b - sqrt discriminant)/ 2*a]
  where discriminant = b * b - 4 * a * c

quadraticf :: Float -> Float -> Float -> Either String (Polynomial Float) 
quadraticf = quadratic
-- 二项式解析法解决.:1 ends here
