
{-
isPosition :: String -> String -> Num
isPosition a b
    | a == b    = 1
    | otherwise = 0
-}

--  charName :: Num -> String -- this doesn't work.  It will cause this error message:
-- position.hs:9:13: error:
--     • Expecting one more argument to ‘Num’
--       Expected a type, but ‘Num’ has kind ‘* -> Constraint’
--     • In the type signature:
--         charName :: Num -> String
--
-- ==================== which is why the signature above didn't work. You can't use Num like that. It has to be
-- ==================== Int, Integer, or someting like that. Num would be in the earlier part of the signature
-- ==================== where you put (like the error message says) constraints with classtypes
{-
charName :: Int -> String
charName 1 = "asdf"
charName 2 = "Broseph"
charName 3 = "Cecil"
-}


isPosition :: String -> String ->Int
isPosition a b
    | a == b    = 1
    | otherwise = 0
