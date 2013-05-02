-- Conway Tang
-- CS 381
-- Homework 3

module HW3 where



-- Exercise 1
type Prog = [Cmd]

data Cmd = LD Int
         | ADD
         | MULT
         | DUP
         | INC
         | SWAP
         | POP Int
         deriving Show

-- (a)
type Rank = Int
type CmdRank = (Int,Int)

--rankC :: Cmd -> CmdRank


--rankP :: Prog -> Maybe Rank


--rank :: Prog -> Rank -> Maybe Rank


-- (b)
--semStatTC :: 



-- Exercise 2
data Shape = X
           | TD Shape Shape
           | LR Shape Shape
           deriving Show

type BBox = (Int,Int)

-- (a)
--bbox :: Shape -> BBox


-- (b)
--rect :: Shape -> Maybe BBox



-- Exercise 3
-- (a)
{-

f x y = if null x then [y] else x
g x y = if not (null x) then [] else [y]

(1) What are the types of f and g?
(2) Explain why the functions have these types.
(3) Which type is more general?
(4) Why do f and g have different types?

-}

-- (b)
--h :: [b] -> [(a,b)] -> [b]


-- (c)
--k :: (a -> b) -> ((a -> b) -> a) -> b


-- (d)

