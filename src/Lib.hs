{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( encodeDataset
    , encodeRow
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


encodeElement :: (Int, String) -> M.Map Int [String] -> [String]
encodeElement rowElem mappedEncodings
  | M.member idx mappedEncodings = foldl (\acc encoding -> acc ++ [encodeBit val encoding]) [] encodings
  | otherwise              = [val]
  where idx = fst rowElem
        val = snd rowElem
        encodings = mappedEncodings M.! idx


encodeBit :: String -> String -> String
encodeBit value encoding
  | value == encoding = "1"
  | otherwise         = "0"


--map over every element in indexedRow... make a partial function with the encodings... [] is the initial accumulator.


--if there's an encoding, encode the row value. if there's not, return the row value.

{-
encodings = M.fromList [(0, ["left", "right", "middle"])]
inputRow = ["left"]
expectedRow = ["1", "0", "0"]
-}

{-
encodings = M.fromList [(0, ["left", "right", "middle"])]
inputRow = ["left", "apple"]
expectedRow = ["1", "0", "0", "apple"]
-}

{-
encodings = M.fromList [ (0, ["left", "middle", "right"])
                       , (2, ["left", "middle", "right"])
                       ]

inputRow    = [     "left",      "100",      "middle",        "100", "200"]
expectedRow = ["1", "0", "0",    "100",    "0", "1", "0",     "100", "200"]
-}

{-
    go encodings indexedRow = ["1", "0", "0"]
    go :: M.Map Int [String]
       -> M.Map Int [String]
       -> [String]
    go encodings indexedRow = ["1", "0", "0"]
-}
