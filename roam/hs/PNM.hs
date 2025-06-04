-- :PROPERTIES:
-- :ID:       c4f56013-2936-4921-9329-2f3361888893
-- :header-args: :tangle hs/PNM.hs :comments both :mkdirp t
-- :END:
-- #+title: img/pnm/hs
-- See [[id:954b06bc-cd6e-4f69-8b96-f95f4970266a][img/pnm]].


-- Haskell 的递归特性，使得它非常适合处理一些递归下降的工作.
-- 在 PNM 的解析中, 所有的实现都是类型安全的, 而每一步都只是简单的纯函数.
-- 这正是为什么 Haskell 说 It comples, It works.


-- [[file:../20250519185416-img_pnm_hs.org::+BEGIN_SRC haskell][No heading:1]]
{-# LANGUAGE OverloadedStrings #-}
module PNM where
import qualified Data.Text as T
import Control.Applicative
-- No heading:1 ends here

-- 递归定义Parser,解析 Token
-- Parser 就 是一个 接受文本而返回解析结果的函数.
-- 我们 使用 newtype 来包装这个函数，这使得程序有更好的类型检查.

-- [[file:../20250519185416-img_pnm_hs.org::*递归定义Parser,解析 Token][递归定义Parser,解析 Token:1]]
type ErrorMessage = String
type ParseResult a = Either ErrorMessage (T.Text, a)

newtype Parser a = Parser
  {runParser :: T.Text -> ParseResult a}
-- 递归定义Parser,解析 Token:1 ends here



-- 我们用 [[id:3ba9443b-e20c-4cdc-bd40-b23dc57a7a2c][hs/functor/Either]]. 来保存解析结果, 这使得我们在解析失败的时候，能够返回一个有意义的错误消息.
-- 当成功时候, 它返回一个 (Text, a) 的元组. a 是类型参数，它表示该解析器解析结果的内部表示类型.
-- 剩下的未解析文本，放在元组的第一个元素.

-- 这个解析结果是递归的, 类似于Lisp的 Atom 和 List.
-- a 就是 atom， Text 就是 List. Text 可以继续被递归解析成其他解析器的内部表示类型.
-- 最终组合成完整的解析器.

-- 我们定义一个比较原始的解析器.它的职责是解析一段字符串.

-- [[file:../20250519185416-img_pnm_hs.org::*递归定义Parser,解析 Token][递归定义Parser,解析 Token:2]]
string :: T.Text -> Parser T.Text
string str =
  Parser $ \t ->
    if T.take (T.length str) t == str
    then Right (T.drop (T.length str) t, str)   
    else Left $ "failed to parse \""
    ++ T.unpack str ++ "\""
-- 递归定义Parser,解析 Token:2 ends here


-- 它做一件很简单的事情，比对输入文本的最开头, 如果大小和给定的字符串一致,返回这个字符串.
-- 当然，还有剩下的文本. 否则返回错误消息.

-- 这个函数是一个高阶函数，它返回一个可以工作的具体函数.

-- 我们现在可以解析文本了，我们首先解析 PNM 的魔数，它标识了 PNM的具体类型.

-- [[file:../20250519185416-img_pnm_hs.org::*递归定义Parser,解析 Token][递归定义Parser,解析 Token:3]]
data MagicNumber = P1 | P2 | P3 | P4 | P5 | P6 deriving (Eq, Show)

magicNumberP1P :: Parser MagicNumber    
magicNumberP1P = P1 <$ string "P1"
magicNumberP2P :: Parser MagicNumber    
magicNumberP2P = P2 <$ string "P2"
magicNumberP3P :: Parser MagicNumber    
magicNumberP3P = P3 <$ string "P3"
magicNumberP4P :: Parser MagicNumber    
magicNumberP4P = P4 <$ string "P4"
magicNumberP5P :: Parser MagicNumber    
magicNumberP5P = P5 <$ string "P5"
magicNumberP6P :: Parser MagicNumber    
magicNumberP6P = P6 <$ string "P6"
-- 递归定义Parser,解析 Token:3 ends here



-- 我们把 魔数定义为 类型，来保证类型的安全性，使用 string 产生字符串解析器来解析魔数.
-- 最后通过 <$ 操作符,将解析结果替换成魔术实例来匹配类型.

-- 使用了 <$，Parser 当然实现了 函子.

-- [[file:../20250519185416-img_pnm_hs.org::*递归定义Parser,解析 Token][递归定义Parser,解析 Token:4]]
instance Functor Parser where
  fmap f p = Parser $ \t -> fmap (fmap f) (runParser p t)
-- 递归定义Parser,解析 Token:4 ends here


-- Parser的函子映射就是把输入文本，转换为内部表达形式.

-- 我们复用 Text.takeWhile 和 dropWhile 实现 takeWhile 解析器.
-- takeWhile 会拿取符号条件的字符，直到输入的函数返回false.

-- [[file:../20250519185416-img_pnm_hs.org::*递归定义Parser,解析 Token][递归定义Parser,解析 Token:5]]
takeWhile :: (Char -> Bool) -> Parser T.Text
takeWhile p = Parser $ \t -> Right
  (T.dropWhile p t, T.takeWhile p t)

spaces :: Parser T.Text
spaces = PNM.takeWhile (' ' ==)
-- 递归定义Parser,解析 Token:5 ends here



-- 同时也可以用于处理整数

-- [[file:../20250519185416-img_pnm_hs.org::*递归定义Parser,解析 Token][递归定义Parser,解析 Token:7]]
integer :: Parser Integer
integer = read . T.unpack <$> PNM.takeWhile (`elem` ['0' .. '9'])
-- 递归定义Parser,解析 Token:7 ends here

-- 组合解析结果, 实现产生式
-- 我们现在想要把 宽度和高度这两个基本的整型Token解析成更有意义的
-- Header 结构.

-- [[file:../20250519185416-img_pnm_hs.org::*组合解析结果, 实现产生式][组合解析结果, 实现产生式:1]]
data Header = Header
  { width :: Integer,
    height :: Integer
  }
  deriving (Show)
-- 组合解析结果, 实现产生式:1 ends here




-- 通过应用函子可以实现这个效果.

-- [[file:../20250519185416-img_pnm_hs.org::*组合解析结果, 实现产生式][组合解析结果, 实现产生式:2]]
instance Applicative Parser where
  pure x = Parser $ \t -> Right (t, x)
  (<*>) a b =
    Parser $ \t ->
      case runParser a t of 
        Left msg -> Left msg 
        Right (rest, f) -> runParser (fmap f b) rest
-- 组合解析结果, 实现产生式:2 ends here



-- 通过应用函子，我们可以把 Header:Integer->Integer->Header 应用到前面的解析器上.
-- *>用于结果的替换, 我们把最后的结果都替换为，最后执行的那个 integer 解析器的结果了.

-- [[file:../20250519185416-img_pnm_hs.org::*组合解析结果, 实现产生式][组合解析结果, 实现产生式:3]]
headerP = Header
          <$> (string "P1" *> spaces *> integer)
          <*> (spaces *> integer)
-- 组合解析结果, 实现产生式:3 ends here



-- #+RESULTS:
-- : Just 1 Just 2


-- [[file:../20250519185416-img_pnm_hs.org::*选择逻辑,实现 EBNF |][选择逻辑,实现 EBNF |:2]]
modifyErrorMessage ::
  (ErrorMessage -> ErrorMessage) ->
  Parser a ->
  Parser a
modifyErrorMessage f p =
  Parser $ \t -> case runParser p t of
                   Left msg -> Left $ f msg
                   result -> result

instance Alternative Parser where
  empty = Parser $ \_ -> Left "empty alternative"
  (<|>) a b =
    Parser $ \t ->
      case runParser a t of              
        Left msg -> runParser (modErr msg b) t  
        right -> right                     
    where
      modErr msg =
        modifyErrorMessage
        (\msg' -> msg ++ " and " ++ msg')
-- 选择逻辑,实现 EBNF |:2 ends here

main = do
  print $ runParser (string "A" <|> string "B") "B"
