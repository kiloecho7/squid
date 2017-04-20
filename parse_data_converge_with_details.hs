{-
              a row             index with categoricals
          [100, 200, left]     (2, [left, middle, Right])  ->  [100, 200, 1, 0, 0]
encode ::    [String] ->           [(int, [String])]       ->  [String]
-}

encode :: [(Int, Int, String)]   ->   [(Int, [String])]   ->   [[Int]]
encode [] []                 = []
encode [] _                  = error "I have encoding keys but no rows."
encode _ []                  = error "I rows of data but no encoding keys."
encode (row:[]) (key:[])     = (encodeOne row key) : []
encode (row:rows) (key:keys) = encodeOne row key : encode rows keys

-- encodeRow :: (Int, Int, String) -> (Int, Int, Int, Int, Int)
-- encoderow     (i1, i2, str)   =   (i1, i2, (encodedCat !! 0), (encodedCat !! 1), (encodedCat !! 2))
--    where encodedCat = encodeCat str

----------- don't need this anymore ---------------
-- encodeCat :: String -> [Int]
-- encodeCat "Left"   = [1, 0, 0]
-- encodeCat "Middle" = [0, 1, 0]
-- encodeCat "Right"  = [0, 0, 1]
---------------------------------------------------

---------------- and we don't need this because it's actually the same as encode -------------------
-- encodeRows ::  [(Int, Int, String)]   -->    ->   [(Int, Int, Int, Int, Int)]
-- encodeRows []     = []
-- encodeRows (x:[]) = encoderow x : []
-- encodeRows (x:xs) = encoderow x : encoderows xs
-------------------------------------------------------------------------------------------------


{-
encode ::  (Int, Int, String)   ->  (Int, [String])  ->  [Int, Int, Int, Int, Int]    <-----   amateur!
encode (input@[v1, v2, pos] (idx, positions)) = [v1, v2] : map isMatch (input!!idx) positions]
-}

encodeOne ::  (Int, Int, String)   ->  (Int, [String])  ->  [Int]
encodeOne input@(v1, v2, pos) (idx, positions) = v1:v2 : map (isMatch position) positions
    where position = getNth input idx


getNth :: (Int, Int, String) -> Int -> String
getNth (_, _, s) n
    | n == 2    = s
    | otherwise = error "The index has to be 2. Sorry, that's all I accept."


isMatch :: String -> String ->Int
isMatch a b
    | a == b    = 1
    | otherwise = 0

{-
key  = (2, ["Left", "Middle", "Right"])
row0 = (100, 200,"Left")
row1 = (110, 211,"Middle")
row2 = (120, 221,"Right")
row3 = (130, 231,"Left")
row4 = (140, 241,"Left")
row5 = (150, 251,"Right")
row6 = (160, 261,"Middle")
row7 = (170, 271,"Middle")
rows = [row0, row1, row2, row3, row4, row5, row6, row7]
keys = [ key,  key,  key,  key,  key,  key,  key,  key]
rows = [row0, row1, row2]
keys = [ key,  key,  key]
encode rows keys
-}
