Note: This file can be directly loaded into ghci.


EXERCISE 1 [20+15 = 35 Points]

The abstract syntax of the the stack language was given in 
the exercise. 

> type Prog = [Cmd]
> 
> data Cmd = LD Int | ADD | MULT | DUP | INC | SWAP | POP Int 
>            deriving Show

The rank of a stack is given by an integer, and the rank of an
operation is given by a pair of integers.

> type Rank    = Int
> type CmdRank = (Int,Int)

(a)
The type checker for a stack program starts with an initial rank of 0
and transforms this rank using the rank information for each
operation.

> rankC :: Cmd -> CmdRank
> rankC (LD _)  = (0,1)
> rankC ADD     = (2,1)
> rankC MULT    = (2,1)
> rankC DUP     = (1,2)
> rankC INC     = (1,1)
> rankC SWAP    = (2,2)
> rankC (POP k) = (k,0)

The rank of a program can be computed as follows.

> rankP :: Prog -> Maybe Rank
> rankP cs = rank cs 0

> rank :: Prog -> Rank -> Maybe Rank
> rank []     s = Just s
> rank (c:cs) s | s<n       = Nothing
>               | otherwise = rank cs (s-n+m) 
>                 where (n,m) = rankC c


(b)
The semantic function can be simplified by removing the Maybe data
type. Static type checking prevents any possible stack errors.

semStatTC :: Prog -> Maybe Stack 
semStatTC p = case rankP p of
                Nothing -> Nothing
                Just r  -> Just (sem [] p)  -- sem cannot fail

The function sem can be implemented with the following type.

sem :: Prog -> Stack -> Stack
sem ... = ...



EXERCISE 2 [15+20 = 35 Points]

(a)
Types as given in the exercise.

> data Shape = X
>            | TD Shape Shape
>            | LR Shape Shape
>            deriving Show
> 
> type BBox = (Int,Int)

Bounding boxes can be computed as follows.

> bbox :: Shape -> BBox
> bbox X           = (1,1)
> bbox (TD s1 s2)  = (max x1 x2, y1+y2)
>                         where (x1,y1) = bbox s1
>                               (x2,y2) = bbox s2 
> bbox (LR s1 s2)  = (x1+x2, max y1 y2)
>                         where (x1,y1) = bbox s1
>                               (x2,y2) = bbox s2 


(b)
In addition to the computations performed by bbox, we have to ensure
that the width (height) of two shapes composed by TD (LR) are the
same.

> rect :: Shape -> Maybe BBox
> rect X          = Just (1,1)
> rect (TD s1 s2) = case (rect s1, rect s2) of
>                     (Just (x1,y1), 
>                      Just (x2,y2)) -> 
>                        if x1==x2 then Just (x1,y1+y2) 
>                                  else Nothing
>                     _              -> Nothing
> rect (LR s1 s2) = case (rect s1, rect s2) of
>                     (Just (x1,y1), 
>                      Just (x2,y2)) -> 
>                        if y1==y2 then Just (x1+x2,y1)
>                                  else Nothing
>                     _              -> Nothing

A very elegant alternative solution, suggested to me by a former
student, is to compute the bounding box and compare the number 
of Xs in the shape to the area of the bounding box.

rect :: Shape -> Maybe BBox
rect s | area s == x*y = Just (x,y) 
       | otherwise     = Nothing
         where (x,y) = bbox s

area :: Shape -> Int
area X         = 1
area (LR e e') = area e + area e'
area (TD e e') = area e + area e'

Even though this implementation is a very clever idea, it violates
in a sense the "spirit" of static type checking, because it employs
a dynamic semantics, namely the function area, that computes more
concrete, fine-grained information than represented by the abstract 
type BBox.



EXERCISE 3 [4*3+6+6+6 = 30 Points]

(a)
f x y = if null x then [y] else x   
g x y = if not (null x) then [] else [y]

(1) 
f :: [a] -> a -> [a]
g :: [a] -> b -> [b]

(2)
Since null :: [a] -> Bool is applied to x, x must be of type [a].
Assuming that y is of some type b, [y] is of type [b]. Since both
branches of a conditional have to have the same type, the types
of [y] and x have to agree. In other words [b] and [a] have to be 
the same. This can be achieved by letting b=a. The result type
of f is determined by the type of the conditional, which is [a].

For g, the same reasoning applies to x and y as in the case for f. The
empty list is of type [c] for any type c. Again, the typing rule for
the conditional forces c and b to be the same (e.g. b) and the result
type to be [b], but b need not be the same as a.

(3) 
The type of g is more general since the type of f can be obtained by
substituting a for b. In other words, g works for argument lists of 
different types whereas f requires both input lists to be of the
same type.

(4)
Since x is not used in the result of g, its type is unconstrained. In
particular, it is not constrained to match that of [y] as in the
definition of f.


(b)
h :: [b] -> [(a, b)] -> [b] 

> h (x:xs) ((y,z):ys) = z:h xs ((y,x):ys)

Much better: h xs [(y,z)] = z:xs


(c)
k :: (a -> b) -> ((a -> b) -> a) -> b

> k f g = f (g f)


(d)
It is difficult to come up with a definition for such a function because
when in a function definition "f x = ..." it is hard to find a value
of type b (since the argument x has type a). So one has to recourse to
tricks like the following.

> f x = undefined
>       where undefined = undefined

Or:

> g x = head []

