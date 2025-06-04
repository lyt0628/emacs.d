-- :PROPERTIES:
-- :ID:       b6e343fd-a96a-480f-a70e-466742fe4de8
-- :header-args:  :tangle hs/Music.hs :comments both
-- :END:
-- #+title: hs/music


-- [[file:../20250514192706-haskell_music.org::+BEGIN_SRC haskell][No heading:1]]
module Music where
-- No heading:1 ends here

-- [[file:../20250514192706-haskell_music.org::+BEGIN_SRC haskell][No heading:2]]
type Sample = Double
type Signal = [Sample]
type Hz = Double
type Seconds = Double

sampleRate :: Double
sampleRate = 44100
samplesPerPeriod :: Hz -> Int
samplesPerPeriod hz = round $ sampleRate / hz

samplesPerSecond :: Seconds -> Int
samplesPerSecond duration = round $ duration * sampleRate
-- No heading:2 ends here

-- 定义常见波形


-- [[file:../20250514192706-haskell_music.org::*定义常见波形][定义常见波形:1]]
type Wave = Double -> Sample
-- 定义常见波形:1 ends here

-- 正弦波


-- [[file:../20250514192706-haskell_music.org::*正弦波][正弦波:1]]
sin :: Wave
sin t = Prelude.sin $ 2 * pi * t
-- 正弦波:1 ends here

-- 方波


-- [[file:../20250514192706-haskell_music.org::*方波][方波:1]]
sqw :: Wave
sqw t
  | t <= 0.5 = -1
  | otherwise = 1
-- 方波:1 ends here

-- 锯齿波

-- [[file:../20250514192706-haskell_music.org::*锯齿波][锯齿波:1]]
saw :: Wave
saw t
  | t < 0 = -1
  | t > 0 = 1
  | otherwise = (2 * t) - 1
-- 锯齿波:1 ends here

-- 三角波

-- [[file:../20250514192706-haskell_music.org::*三角波][三角波:1]]
tri :: Wave
tri t
  | t < 0 = -1
  | t > 1 = 1
  | t < 0.5 = 4 * t - 1
  | otherwise = -4 * t + 3
-- 三角波:1 ends here

-- 寂静产生器

-- [[file:../20250514192706-haskell_music.org::*寂静产生器][寂静产生器:1]]
silence :: Seconds -> Signal
silence t = replicate (samplesPerSecond t) 0
-- 寂静产生器:1 ends here

-- 波形产生器

-- [[file:../20250514192706-haskell_music.org::*波形产生器][波形产生器:1]]
tone :: Wave -> Hz -> Seconds -> Signal

tone wave freq t = map wave periodValues
  where
    nSamples = samplesPerPeriod freq
    periodValues =
      map
      (\x -> fromIntegral (x `mod` nSamples) / fromIntegral nSamples) -- 模操作控制输入范围， 然后进行归一化
      [0 .. samplesPerSecond t] --  生成 0 到最大采样次数的列表
-- 波形产生器:1 ends here



-- 采样时间给定，波形是确定的，得到采样点就是确定的.
-- 频率高采样采得多，更贴合原波形.




-- [[file:../20250514192706-haskell_music.org::*波形产生器][波形产生器:2]]
import Data.Array.Unboxed (listArray)
import Data.Audio
main = do
  print $ "ok"
-- 波形产生器:2 ends here
