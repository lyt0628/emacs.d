-- :PROPERTIES:
-- :ID:       2f7a6223-93db-4375-9711-3b987bff16ce
-- :header-args: :tangle hs/Normal.hs :comments both
-- :END:
-- #+title: cg/normal/hs



-- [[file:../20250518042850-cg_normal_hs.org::+BEGIN_SRC haskell][No heading:1]]
data Norm2D a = Norm2D a a deriving (Eq, Show, Functor)
data Norm3D a = Norm3D a a a deriving (Eq, Show, Functor)
-- No heading:1 ends here
