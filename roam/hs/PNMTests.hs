
{-# LANGUAGE OverloadedStrings #-}
import PNM

main :: IO()
main = do
  let a = runParser (string "P1") "P1 100 100"
  print $ (show a)
