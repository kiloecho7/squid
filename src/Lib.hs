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
    go :: undefined
    go = undefined
