-- Conway Tang
-- CS 381
-- Homework 2

module HW2 where


-- Exercise 1
type Prog = [Cmd]

data Cmd = LD Int
         | ADD
         | MULT
         | DUP
         deriving Show

type Stack = [Int]

type D = Stack -> Stack

-- sem :: Prog -> D
-- sem :: Prog -> Stack -> Stack
-- sem plist xs = 

semCmd :: Cmd -> D
-- SemCmd :: Cmd -> Stack -> Stack
semCmd (LD i) xs = i:xs
semCmd ADD xs = (head (take 2 xs) + last (take 2 xs)):(drop 2 xs)
semCmd MULT xs = (head (take 2 xs) * last (take 2 xs)):(drop 2 xs)
semCmd DUP xs = (head xs):xs

prog1 = [LD 3, DUP, ADD, DUP, MULT]
prog2 = [LD 3, ADD]
prog3 = []


-- Exercise 2


-- Exercise 3
data Lcmd = Pen Mode
          | MoveTo Int Int
          | Seq Lcmd Lcmd
          deriving Show

data Mode = Up | Down
          deriving Show

type State = (Mode, Int, Int)
type Line = (Int, Int, Int, Int)
type Lines = [Line]

-- semS :: Lcmd -> State -> (State, Lines)


-- sem' :: Lcmd -> Lines
