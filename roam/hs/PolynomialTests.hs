module PolynomialTests where

import qualified Polynomial as P

main = do
  let f = P.quadraticf 2 10 1
  print $ show f
