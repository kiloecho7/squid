{-
              a row             index with categoricals
          [100, 200, left]     (2, [left, middle, Right])  ->  [100, 200, 1, 0, 0]
encode ::    [String] ->           [(int, [String])]       ->  [String]
-}

{-
encode :: [(Int, Int, String)]   ->   [(Int, [String])]   ->   [(Int, Int, Int, Int, Int)]
encode [] []  = []
encode [] _   = error "I have encoding keys but no rows."
encode _ []   = error "I rows of data but no encoding keys."
encode (row:rows) _ = encoderow row : encoderows rows

encoderow :: (Int, Int, String) -> (Int, Int, Int, Int, Int)
encoderow     (i1, i2, str)   =   (i1, i2, (encodedCat !! 0), (encodedCat !! 1), (encodedCat !! 2))
   where encodedCat = encodeCat str

encodeCat :: String -> [Int]
encodeCat "Left"   = [1, 0, 0]
encodeCat "Middle" = [0, 1, 0]
encodeCat "Right"  = [0, 0, 1]

encoderows ::  [(Int, Int, String)]   ->   [(Int, Int, Int, Int, Int)]
encoderows []     = []
encoderows (x:[]) = encoderow x : []
encoderows (x:xs) = encoderow x : encoderows xs
-}

{-
encode ::  (Int, Int, String)   ->  (Int, [String])  ->  [Int, Int, Int, Int, Int]
encode (input@[v1, v2, pos] (idx, positions)) = [v1, v2] : map isPosition (input!!idx) po]
-}

--map function list
--map (function) list
--map (partially applied function) list
--map (isPosition thePosition) thePossiblePositions
--map (isPosition input!!idx) thePossiblePositions
-------------------------- a simple start ----------------------------
-- encode ::  (Int, Int, String)   ->  (Int, [String])  ->  Int
-- encode input@(v1, v2, pos) (idx, positions) = input!!idx
----------------------------------------------------------------------

-------------------------- more simple baby steps ----------------------
-- encode ::  (Int, Int, String)   ->  (Int, [String])  ->  (String, Int)
-- encode input@(v1, v2, pos) (idx, positions) = (pos, idx)
----------------------------------------------------------------------

------------------------ do as-patterns really work? ------------------------------
-- encode ::  (Int, Int, String)   ->  (Int, [String])  ->  ((Int, Int, String), Int)
-- encode input@(v1, v2, pos) (idx, positions) = (input, idx)
-----------------------------------------------------------------------------------

----------------------- alright. let's call getNth --------------------------------
-- encode ::  (Int, Int, String)   ->  (Int, [String])  ->  String
-- encode input@(v1, v2, pos) (idx, positions) = getNth input idx
-----------------------------------------------------------------------------------

----------------------- now let's encode... well, just the first one for now ----------------
encode ::  (Int, Int, String)   ->  (Int, [String])  ->  [Int]
encode input@(v1, v2, pos) (idx, positions) = map (isPosition position) positions
    where position = getNth input idx
----------------------------------------------------------------------------------------------



-- encode (1,2,"Left") (2, ["Left", "Middle", "Right"])


--------------- since the tuple is a distinct type
getNth :: (Int, Int, String) -> Int -> String
getNth (_, _, s) n
    | n == 2    = s
    | otherwise = error "The index has to be 2. Sorry, that's all I accept."


isPosition :: String -> String ->Int
isPosition a b
    | a == b    = 1
    | otherwise = 0
