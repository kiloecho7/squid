

-- squid


{-
getting the nth element of the "row" or "input" tuple doesn't make any sense. It's a tuple so it has a type. its type is (Int, Int, String).
The index in our example is 2.


so what if the input was (100, "Middle", 200, 300) -- the size of the tuple is different and the location of categorical is different.

-}


getNth :: (Int, Int, String) -> Int -> String
getNth (_, _, s) n
    | n == 2    = s
    | otherwise = error "The index has to be 2. Sorry, that's all I accept."
