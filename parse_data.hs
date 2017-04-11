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
