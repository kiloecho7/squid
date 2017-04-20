{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( encodeDataset
    , encodeRow
    ) where

import qualified Data.Map.Strict as M

--Cat = Left | Middle | Right



{-
              a row             index with categoricals
          [100, 200, left]     (2, [left, middle, Right])  ->  [100, 200, 1, 0, 0]
encode ::    [String] ->           [(int, [String])]       ->  [String]
-}


--this was just as a reminder on the function syntax
--doubleMe x = x + x





--------------- ok. let's start with something simple. let's just see if we can parse the first part, what i've termed "a row". Actually,
--------------- I belive that's supposed to be a list of lists of Strings, [[String]], so let's do that.




----- so if we take the function syntax example of "doubleMe"...
----- I need more. I'm not sure if I need to specify that we're.... yea, I think I need to specify that it's a list (or lists) coming in. Sucks, because it's hardcoding the type... I think.... do we have to specify it? I don't think that's how it's done when we do the x:xs pattern. OK, let's try it without first.

--flatten xs = bah!! I can't even get past this. arg!! To the book....


--(ok. huge gap in time there. I bought the Learn You a Haskell book. It's about time. I've been thinking I should for a while now.)


{-
--ok. let's give this a whack.
flatten xs
flatten [] = "What!?"
flatten []:x = x       -----    i think this will fail. i have "xs" in the function definition but not x.
flatten x:xs =
-}
-------- no. this is confining it to a list. we can do this with a fold.



{-
flatten xs = foldl (+) xs         --fold left is the one that is safe for infiite lists? (doesn't apply here. just taking advantage of an opportunity to show off something i know.)
                                  -- i'm spending too much time trying to remember things. no more. going to the book/docs as much as i need to.
-}




-- an example from the book
-- maximum' :: (Ord a) => [a] -> a
-- maximum' [] = error "maximum of empty list!"
-- maximum' [x] = x
-- maximum' (x:xs) = max x (maximum' xs)


-- going back to hard coded list. i can do this one. then we'll change to a fold
-- flatten :: (String a) [a] -> [a]                                -- not concerned about putting a type on it right now. concerned about getting some feedback right now.
-- flatten  [] = "Bleh"
-- flatten  [x] = x
-- flatten  (x:xs) = x + " -- " + flatten xs
--- doesn't work. tried a few thing. I don't understand the error message. --   • Expecting two fewer arguments to ‘String’
--                                                                                Expected kind ‘* -> * -> *’, but ‘String’ has kind ‘*’


-- going  back further in the book for an example that has lists of Strings.



------------ it's been a while. I can't find one. No happy. Frustrated. Way harder than I thought. But like the time I tried a real problem in codewars.







--- ok. let's simplify it more.  baby steps.

--doubleMe x = x + x             -- alright. that's pretty much the begining.
                                 -- look at that! it compiles!
                                 -- but it doesn't work if a pass in a String. OK, the string concat operator is ++.
--doubleMe x = x ++ x            -- but this one does.





-- ok. let's do recursion now. let's reverse a list.
-- myreverse :: [a] -> [a]
-- myreverse [] = []
-- myreverse [x] = [x]           -- let's go ahead and stop here and see if what we have so far is right. -- it is :) ok. less frustration, more happiness.
--myreverse x:xs = myreverse [xs]:x        -- that looks right. let's see. -- Argg!
--myreverse x:[xs] = (myreverse [xs]) : x    -- dang it. k, let's look at the book.
-------- parens on the pattern??
--myreverse (x:[xs]) = (myreverse [xs]) : x      -- wow. that blew up.
--myreverse (x:xs) = (myreverse xs) : x          -- that blew up too. ok. more book.
------ Ah!! It's because : is to prepend one item to a list. We need ++ here! Dang it! Disclosure: i kept looking through examples in the book and the one that finally had all the parts i needed for this promblem... the reverse example  :\
-- myreverse (x:xs) = (myreverse xs) ++ [x]            -- and both sides have to be lists
-- ok. that works... what now...








{-
                                index with categoricals
              "row"                      "key"
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






myreverse :: [a] -> [a]
myreverse [] = []
myreverse [x] = [x]
myreverse (x:xs) = (myreverse xs) ++ [x]


-- --           row                 key                   result
-- encode :: [a, a , b]   ->   (n, [s, s, s])   ->   [a, a, x, x, x]
-- encode _ _ = [100, 200, 1, 0, 0]

-- a: it looks like their ints but let's not assume that. It looks like we can assume they are the same type.
-- b: definitely not the same type as the first two elements in the row. I think we can make that a string for now.
-- n: probably also an int. we know it's an index for row so, yes, it's an int.
-- s: I keep wondering if defining a data type for this will make it easier right now and if by using strings and being verbose like this it will make it harder to get this first solution running.
-- a: these are the same guys that came in in row so we're just passing them along.
-- x: probably ints but let's not assume that.

------------- ok. let's see if that will compile.
------------- it doesn't. back to simple.


-- encode :: (Num a, Num x) => [(a, a , b)]   ->   [(n, [s])]   ->   [(a, a, x, x, x)]
-- encode _ _ = [(100, 200, 1, 0, 0)]

-- ok. this compiles, but i don't like how I had to add the type classes
--- holy ....! It runs too!


-- k. next little baby step
-- encode :: (Num a, Num x)   =>    [(a, a , b)]   ->   [(n, [s])]   ->   [(a, a, x, x, x)]
-- encode [] [] = []
-- encode [(v1, v2, catVal)] _ = [(v1, v2, 1, 0, 0)]




-- but it can only handle one row in the list of rows
-- encode :: (Num a, Num x)   =>    [(a, a , b)]   ->   [(n, [s])]   ->   [(a, a, x, x, x)]
-- encode [] [] = []
-- encode [(v1, v2, catVal)] _ = [(v1, v2, 1, 0, 0)]
-- encode [row:rows] _ = encoderow row : encoderows rows    ---------   my thoughts for now (doesn't seem right but it's a starting point) ----- we'll pick up here tomorrow

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


-- for this input
-- let row1 = (110, 210, "Left")
-- let row2 = (120, 220, "Middle")
--             vvv
-- i need this output
-- [(110, 210, ...), (120, 220, "Middle")]
