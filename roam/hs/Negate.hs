-- :PROPERTIES:
-- :ID:       2f22110d-468d-4a48-ba23-71d4a5fe5a5a
-- :header-args: :tangle hs/Negate.hs :comments both
-- :END:
-- #+title: algebra/negate


-- [[file:../20250515223523-algebra_negate.org::+BEGIN_SRC haskell][No heading:1]]
module Negatable where

class Negatable a where
  negate :: a -> a
-- No heading:1 ends here
