--Cat = Left | Middle | Right



{-
              a row             index with categoricals
          [100, 200, left]     (2, [left, middle, Right])  ->  [100, 200, 1, 0, 0]
encode ::    [String] ->           [(int, [String])]       ->  [String]
-}

-- A summary of the problem
--    Take element n. find out which of the categoricals it is. get the encoding of that categorical. concat it to that row.

-- side note: started thinking about whether I should write tests here. Took a minute to read up on whether unit tests are used in Haskell.
--            I won't be writing tests for this thought (possibly later but not now). I need to understand the problem all the way first. I don't have a complete picture of the whole problem yet.
--
-- Question I still have about the complete picture
--    In the "row" argument, can the elements be in different places? Let's assume no for now to keep it simple.
--    Will the categoricals in the "key" argument be passed in as a new data type that we've defined or as an actual list like they're shown above. again, keep it simple for now, no custom data type, just pass them in like that every time.
--    How do we know what the "index" in "key" is? I guess we'll just assume it's always 2 in this problem.

{-  Test Data
let row1     = (110, 210, "Left")
let row2     = (120, 220, "Middle")
let rows     = row1:row2:[]
let rows_rev = row2:row1:[]

encode rows [(999, ["n/a"])]


-}


-- ****** The key is not being passed to the helper functions right now
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








-- .
