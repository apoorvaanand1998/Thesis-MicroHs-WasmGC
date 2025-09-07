module MicroHs.WasmGCEncode ( toStringWasm ) where

import MicroHs.Exp ( Exp(..) )
import MicroHs.Expr ( Lit(LPrim, LInt) )
import WasmGC.WAT
    ( emit, Instr(StructNew, I32Const, TableGet, RefI31) )
import WasmGC.Identifiers
    ( Identifier(ValueType, AppNodeType, TableFnDefs) )
import WasmGC.Choreograph ( prim )
import MicroHs.Ident ( showIdent )

-- idk if this version of the "difference list" way helps with perf
-- TODO: Investigate later
toStringWasm :: Exp -> (String -> String)
toStringWasm e = (emit (toWasmInstrs e) ++) . (' ' :)

toWasmInstrs :: Exp -> [Instr]
toWasmInstrs (Lam _ _) = error "Lambdas shouldn't exist at this point"
toWasmInstrs (App x y) =  toWasmInstrs x ++ toWasmInstrs y
                       ++ [ StructNew AppNodeType ]
-- for variables do a table lookup with the identifier you want as the index
-- this will return a reference to an appNode that is the definition of our fn
toWasmInstrs (Var v)   = [ I32Const tIdx, TableGet TableFnDefs ]
    where
        tIdx = read (tail (showIdent v)) :: Int
-- treating ints as special, no tagged union repr needed
toWasmInstrs (Lit (LInt i))  = [ RefI31 i ]
toWasmInstrs (Lit (LPrim p)) = [ prim (c2HsNotation p) ]
-- for now I've got no idea how to go about implementing these below
-- so all become "values" (not really, only in type and not for real)
-- and I don't think I am gonna need them anyway
toWasmInstrs (Lit _)         = notImpVal

c2HsNotation :: String -> String
c2HsNotation "S'"  = "SS"
c2HsNotation "B'"  = "BB"
c2HsNotation "C'"  = "CC"
c2HsNotation "C'B" = "CCB"
c2HsNotation  x    = x

notImpVal :: [Instr]
notImpVal = [RefI31 42, RefI31 42, StructNew ValueType]

{- 
    Let's try to note down what primitives we actually support
    Each primitive will be given a i31ref
    
    For now, based on eval, here are the primitives and their respective
    i31ref based tags/codes

    0 - S
    1 - K
    2 - I
    3 - B
    4 - C
    5 - A
    6 - Y
    7 - SS/S'
    8 - BB/B'
    9 - CC/C'
    10 - P
    11 - R
    12 - O
    13 - U
    14 - Z
    15 - K2
    16 - K3
    17 - K4
    18 - CCB/C'B
    19 - ADD
-}