-- :PROPERTIES:
-- :ID:       1433c0e7-9496-4a8a-a217-f0dd5c7ff50c
-- :header-args: :tangle hs/Distributions.hs :comments both
-- :END:
-- #+title: hs/util/distributions


-- Haskell 没有内置 高斯分布生成器，我们得自己实现.


-- [[file:../20250519161401-hs_util_distributions.org::+BEGIN_SRC haskell][No heading:1]]

-- No heading:1 ends here

import Graphics.Rendering.OpenGL
import Graphics.GLU

main :: IO ()
main = do
  (_progName, _args) <- getArgsAndInitialize
  _window <- createWindow "OpenGL Demo"

display = do
  clear [ColorBuffer]
  renderPrimitive Triangles $ do
    vertex $ Vertex2 (-0.5) (-0.5)
    vertex $ Vertex2 0.5 (-0.5)
    vertex $ Vertex2 0 0.5
