{-# LANGUAGE InstanceSigs #-}
module WasmGC.Identifiers where

data MetaVars = X | Y | Z | W | V deriving Enum

data Identifier = LASVar | LasIdx 
                | StackType | AppNodeType | ValueType | IOArrayType
                | LeftField | RightField | LocalCombIdx -- currently "$ascii", but that doesn't fit anymore
                | CombCase | TempVar | ReturnVar
                | TableFnDefs
                | MV MetaVars | FnReduce

instance Show MetaVars where
    show :: MetaVars -> String
    show X = "$x"
    show Y = "$y"
    show Z = "$z"
    show W = "$w"
    show V = "$v"

instance Show Identifier where
    show :: Identifier -> String
    show LASVar       = "$las"
    show LasIdx       = "$n"
    show StackType    = "$stack"
    show AppNodeType  = "$appNode"
    show ValueType    = "$value"
    show IOArrayType  = "$ioarray"
    show LeftField    = "$left"
    show RightField   = "$right"
    show LocalCombIdx = "$ascii"
    show CombCase     = "$combCase"
    show TempVar      = "$temp"
    show ReturnVar    = "$r"
    show TableFnDefs  = "$fnDefs"
    show (MV mv)      = show mv
    show FnReduce     = "$i31OrReduce"