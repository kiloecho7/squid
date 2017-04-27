{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( encodeDataset
    , encodeRow
    , encodeBit
    ) where

import qualified Data.Map.Strict as M

encodeDataset :: [[String]] -> M.Map Int [String] -> [[String]]
encodeDataset dataset encodings = map (encodeRow encodings) dataset

encodeRow :: M.Map Int [String] -- This is the same as [(Int, [String])] except it is easier to work with
          -> [String]           -- input row
          -> [String]           -- output row with encoded categoricals
encodeRow encodings row =
  let indexedRow = zip [0..] row -- hint add an index to each element so you know what index you are on when you map over it
  in go indexedRow encodings []
  where
    go :: [(Int, String)] -> M.Map Int [String] -> [String] -> [String]
    go indexedRow encodings acc = foldl (\acc rowElem -> acc ++ encodeElement rowElem encodings) acc indexedRow    
--leaving this lambda. in actual prodution code i'd replace it because I replaced the other one. It's 11:30 pm and I'm struggling to think so I need to stick to the important refactorings.


--TODO ++ is okay here because our lists are small but it's not performant for large lists. can we use foldr and : instead? 
--renamed val to rowElemValue. val wasn't expressive enough.
--changed "M.member idx mappedEncodings" to "idx `M.member` mappedEncodings". It reads better
--pulled out the whole lambda, made a function that does that calculation *and* made a partially applied version of it.
encodeElement :: (Int, String) -> M.Map Int [String] -> [String]
encodeElement rowElem mappedEncodings
  | idx `M.member` mappedEncodings = foldr theFoldFunction' encodings []
  | otherwise                      = [rowElemValue]
  where idx              = fst rowElem
        rowElemValue     = snd rowElem
        encodings        = mappedEncodings M.! idx
        theFoldFunction' = theFoldFunction rowElemValue


--TODO can [String] be changed to [a]? IIRC the compiler will see that it's always a String that's passed in and it will complain. Maybe it's only a warning.
--since there's only one function body are the types even needed? 
--yay! we got to show off 'let'!
theFoldFunction :: String -> String -> [String] -> [String]
theFoldFunction rowElemValue encoding acc =
  let encoded = (encodeBit rowElemValue encoding)
  in (encoded : acc)


--TODO There's *got* to be a much much more succinct way of doing this
encodeBit :: String -> String -> String
encodeBit value encoding
  | value == encoding = "1"
  | otherwise         = "0"
