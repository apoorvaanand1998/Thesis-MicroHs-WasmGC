{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module PackageInfo_MicroHs (
    name,
    version,
    synopsis,
    copyright,
    homepage,
  ) where

import Data.Version (Version(..))
import Prelude

name :: String
name = "MicroHs"
version :: Version
version = Version [0,13,3,0] []

synopsis :: String
synopsis = "A small compiler for Haskell"
copyright :: String
copyright = "2023,2024,2025 Lennart Augustsson"
homepage :: String
homepage = ""
