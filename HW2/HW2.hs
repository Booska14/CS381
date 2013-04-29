-- Conway Tang
-- CS 381
-- Homework 2

module HW2 where

import SVG (ppLines)
import Data.Maybe
import Data.List
import System.IO

-- Exercise 1
type Prog = [Cmd]

data Cmd = LD Int
         | ADD
         | MULT
         | DUP
         deriving Show

type Stack = [Int]

--type D = Stack -> Stack
type D = Maybe Stack -> Maybe Stack

sem :: Prog -> D
sem [] a = a
sem (o:os) b = sem os (semCmd o b)

semCmd :: Cmd -> D
semCmd (LD e) xs =
       case xs of
            Just xs -> if e < 0
                 then Nothing
                 else Just (xs ++ [e])
semCmd ADD xs = 
       case xs of
            Just xs -> if length xs < 2
                 then Nothing
                 else Just (init(init xs) ++ [last xs + last(init xs)])
semCmd MULT xs =
       case xs of
            Just xs -> if length xs < 2
                 then Nothing
                 else Just (init(init xs) ++ [last xs * last(init xs)])
semCmd DUP xs =
       case xs of
            Just xs -> if length xs < 1
                 then Nothing
                 else Just (xs ++ [(last xs)])            

-- stacks
s1 = Just []
s2 = Just [1,2,3,4]

-- programs
p1 = [LD 3,DUP,ADD,DUP,MULT]
p2 = [LD 3,ADD]
p3 = []

-- tests
t1 = sem p1 s1 --should pass
t2 = sem p2 s1 --should fail
t3 = sem p1 s2


-- Exercise 2
-- (a)
data Cmd2 = LD2 Int
          | ADD2
          | MULT2
          | DUP2
          | DEF String [Cmd]
          | CALL String
          deriving Show

-- (b)
type Macros = [(String,Prog)]
type State = (Stack,Macros)

-- (c)
-- sem2 :: Prog -> D


-- semCmd2 :: Cmd -> D



-- Exercise 3
data Cmd3 = Pen Mode
          | MoveTo Int Int
          | Seq Cmd3 Cmd3
          deriving Show

data Mode = Up | Down
          deriving Show

type State = (Mode,Int,Int)
type Line = (Int,Int,Int,Int)
type Lines = [Line]

semS :: Cmd3 -> State -> (State,Lines)
semS (Pen Up) (Up,e,f) = ((Up,e,f),[])
semS (Pen Down) (Up,e,f) = ((Down,e,f),[])
semS (Pen Down) (Down,e,f) = ((Down,e,f),[])
semS (Pen Up) (Down,e,f) = ((Down,e,f),[])
semS (MoveTo e f) (Down,g,h) = ((Down,e,f),(g,h,e,f):[])
semS (MoveTo e f) (Up,g,h) = ((Up,e,f),[])

-- sem' :: Lcmd -> Lines
