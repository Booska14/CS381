-- Conway Tang
-- CS 381
-- Homework 1

module HW1 where

-- Exercise 1
-- (a)
data Cmd = Pen Mode
         | MoveTo Pos Pos
         | Def String Pars Cmd
         | Call String Vals
         | Cmd_List Cmd Cmd
         | Noop
         deriving Show

data Name = Name String
          deriving Show

data Number = Number Int Int
            deriving Show

data Mode = Up | Down
          deriving Show

data Pos = P Int Int | S Name
         deriving Show

data Pars = PP Name Pars | PS String
          deriving Show

data Vals = VP Number Vals | VS Number
          deriving Show

-- (b)
vector = Def "vector" (PS "par1") (MoveTo (P 1 2) (P 1 3))

-- (c)
--steps :: Int -> Cmd
--steps 0 = Empty
--steps 1 = (CmdList
--        (Pen Down)
--        (CmdList                
--                (MoveTo (P 0 0) (P 0 1))
--                (CmdList
--                        (MoveTo (P 0 1) (P 1 1))
--                        (Pen Up)
--                        )))
--steps n = (CmdList
--        (Pen Down)
--        (CmdList
--                (MoveTo (P (n-1) (n-1)) (P (n-1) n))
--                (CmdList
--                        (MoveTo (P (n-1) n) (P n n))
--                        (CmdList
--                                (Pen Up)
--                                (steps (n - 1))
--                                ))))



-- Exercise 2
-- (a)
data Circuit = C Gates Links
             deriving Show

data Gates = G Int GateFn Gates
           | NoGates
           deriving Show

data GateFn = And | Or | Xor | Not
            deriving Show

data Links = L Int Int Int Int Links
           | NoLink
           deriving Show

-- (b)
adder = C (G 1 Xor (G 2 And NoGates)) (L 1 1 2 1 (L 1 2 2 2 NoLink))
gate = G 1 Xor (G 2 And NoGates)
link = L 1 1 2 1 (L 1 2 2 2 NoLink)

-- (c)
ppNum :: Int -> String
ppNum 1 = "1"
ppNum 2 = "2"

ppGateFn :: GateFn -> String
ppGateFn Xor = "Xor"
ppGateFn And = "And"

ppGates :: Gates -> String
ppGates (G n f g) = ppNum n++":"++ppGateFn f++";"++ppGates g
ppGates g = ""

ppLinks :: Links -> String
ppLinks (L a b c d l) = "from "++ppNum a++"."++ppNum b++" to "++ppNum c++"."++ppNum d++";"++ppLinks l
ppLinks l = ""

ppCircuit :: Circuit -> String
ppCircuit (C g l) = ppGates g++ppLinks l


-- Exercise 3
data Expr = N Int
          | Plus Expr Expr
          | Times Expr Expr
          | Neg Expr
          deriving (Show)

data Op = Add | Multiply | Negate
        deriving (Show)

data Exp = Num Int
         | Apply Op [Exp]
         deriving (Show)

-- (a)
a = Times (Neg (Plus (N 3) (N 4))) (N 7)
b = Apply Multiply [Apply Negate [Apply Add [Num 3, Num 4]], Num 7]

-- (b)
-- The disadvantage of the alternative abstract syntax is that it is more verbose

-- (c)
translate :: Expr -> Exp
translate (N x) = (Num x)
translate (Plus x y) = (Apply Add [translate x, translate y])
translate (Times x y) = (Apply Multiply [translate x, translate y])
translate (Neg x) = (Apply Negate [translate x])