-- Conway Tang
-- CS 381
-- Homework 3

module HW3 where

import Shape
import GHC.Prim
import Unsafe.Coerce

-- Exercise 1
type Prog = [Cmd]
type Stack = [Int]

data Cmd = LD Int
         | ADD
         | MULT
         | DUP
         | INC
         | SWAP
         | POP Int
         deriving Show

type D = Stack -> Stack

-- (a)
type Rank = Int
type CmdRank = (Int,Int)

rankC :: Cmd -> CmdRank
rankC (LD _) = (0,1)
rankC ADD = (2,1)
rankC MULT = (2,1)
rankC DUP = (1,2)
rankC INC = (1,1)
rankC SWAP = (2,2)
rankC (POP k) = (k,0)

rankP :: Prog -> Maybe Rank
rankP [] = Just 0
rankP (x:xs) = if (0 - fst(rankC x) < 0)
                  then Nothing
                  else rank xs (snd(rankC x)-fst(rankC x))

rank :: Prog -> Rank -> Maybe Rank
rank [] n = Just n
rank (x:xs) n = if (n - fst(rankC x) < 0)
                   then Nothing
                   else rank xs (snd(rankC x)-fst(rankC x)+n)

--programs
p11 = [LD 1,LD 2,LD 3]
p12 = [LD 1,LD 2,ADD,MULT]
p13 = [LD 1,SWAP]
p14 = [LD 0,LD 0,POP 2,POP 1]

--tests
t11 = rankP p11 --Just 3
t12 = rankP p12 --error
t13 = rankP p13 --error
t14 = rankP p14 --error


-- (b)
sem2 :: Prog -> D
sem2 [] a = a
sem2 (o:os) b = sem2 os (semCmd o b)

semCmd :: Cmd -> D
semCmd (LD e) xs = xs ++ [e]
semCmd ADD xs = init(init xs) ++ [last xs + last(init xs)]
semCmd MULT xs = init(init xs) ++ [last xs * last(init xs)]
semCmd DUP xs = xs ++ [(last xs)]
semCmd INC xs = init xs ++ [(last xs) + 1]
semCmd SWAP xs = init(init xs) ++ [last xs] ++ [last(init xs)]
semCmd (POP k) xs = take ((length xs) - k) xs

semStatTC :: Prog -> Maybe Stack
semStatTC p | rankP p == Nothing = Nothing
            | otherwise = Just (sem2 p [])

--tests
t15 = semStatTC p11
t16 = semStatTC p12

{- Now that we have the type checking ahead of time (to insure the validity of the
programs), it's not needed while determining the semantics. This means that the type of
sem is now:
"Prog -> Stack -> Stack" instead of "Prog -> Maybe Stack -> Maybe Stack"
-}

-- Exercise 2
--data Shape = X
--           | TD Shape Shape
--           | LR Shape Shape
--           deriving Show

--helper fucntions
rangeX x1 = maximum (fst(unzip x)) - minimum (fst(unzip x))+1
            where x = (sem x1)

rangeY x1 = maximum (snd(unzip x)) - minimum (snd(unzip x))+1
            where x = (sem x1)

type BBox = (Int,Int)

-- (a)
bbox :: Shape -> BBox
bbox x1 = (rangeX x1,rangeY x1)

--tests
t21 = bbox s1 --(2,2)
t22 = bbox s2 --(2,2)
t23 = bbox s3 --(4,1)

-- (b)
rect :: Shape -> Maybe BBox
rect x1 = if ((rangeX x1)*(rangeY x1) /= length (sem x1))
             then Nothing
             else Just (rangeX x1,rangeY x1)

--tests
t24 = rect s1 --not a rectangle
t25 = rect s2 --square, which is a rectangle
t26 = rect s3 --is a rectangle


-- Exercise 3
-- (a)
f x y = if null x then [y] else x
g x y = if not (null x) then [] else [y]

{-
(1) What are the types of f and g?
    :t f = f :: [t] -> t -> [t]
    :t g = [a] -> a1 -> [a1]
(2) Explain why the functions have these types.
(3) Which type is more general?
(4) Why do f and g have different types?
-}

-- (b)
h :: [b] -> [(a,b)] -> [b]
h a b = (snd(unzip b))

-- (c)
k :: (a -> b) -> ((a -> b) -> a) -> b
k a b = a $ b $ a

-- (d)
m :: a -> b
m x = unsafeCoerce x
