{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ViewPatterns #-}
module WasmGC.MyLib where

import WasmGC.Choreograph
import WasmGC.WAT ( emit )
import WasmGC.ReductionRules
import qualified Data.Text.Lazy as T
import qualified Data.Text.Lazy.Encoding as TE
import qualified Data.Text.Lazy.IO as TIO
import qualified Data.ByteString.Lazy as BL
import System.Directory ( removeFile, renameFile )

pathPrefix :: String
pathPrefix = "/home/spirit/Desktop/Programs/Thesis/MicroHs-ghc/"

genCombs :: IO ()
genCombs = mapM_ genComb combCodes

combCodes :: [GraphInstr]
combCodes = zipWith Check combs redRules

genComb :: GraphInstr -> IO ()
genComb g = do
    writeComb g
    rmAndMv

rmAndMv :: IO ()
rmAndMv = do
    removeFile (pathPrefix ++ "SKeleton.wat")
    renameFile (pathPrefix ++ "skGen.wat") (pathPrefix ++ "SKeleton.wat")

-- takes combinator and generated code for that comb
-- takes code from SKeleton.wat and writes to skGen.wat
writeComb :: GraphInstr -> IO ()
writeComb is@(Check c _) = do
    fb <- BL.readFile (pathPrefix ++ "SKeleton.wat")
    let ft = TE.decodeUtf8 fb
    -- doing it this way because of 
    -- https://hackage-content.haskell.org/package/text-2.1.2/docs/Data-Text-Lazy-IO.html#v:readFile
        untilStart = f1 start ft
        rest       = f2 end   ft
        r = [untilStart, T.pack start, T.pack (emit (toWatInstr is)), "\n", T.pack end, rest]
    TIO.writeFile (pathPrefix ++ "skGen.wat") $ T.concat r
    where
        start = ";; " ++ c ++ " Combinator Start\n"
        end   = ";; " ++ c ++ " Combinator End\n"
        split' x = T.splitOn (T.pack x)

        f1 x (split' x -> [untilStart, _]) = untilStart
        f1 x _                             = error (x ++ " Error while splitting on Start")

        f2 x (split' x -> [_, rest])       = rest
        f2 x _                             = error (x ++ " Error while splitting on End")

writeComb _ = error "writeComb only works with Check"