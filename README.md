The code relevant to this project is contained in:

- src/WasmGC - For the Wasm AST and DSL. 5 modules in total
  - Choreograph.hs - Sets up the datatypes used for the DSL
  - WAT.hs - For the Wasm AST
  - Identifiers.hs - Constructors to make sure you don't use identifiers that are not present in the RTS
  - ReductionRules.hs - Every reduction rule that I implemented is in here
  - MyLib.hs - Runs everything and puts it in SKeleton.wat

- SKeleton.wat - Handwritten Wasm RTS

Some other modules that were modified or added are:

- Script.Try - Basically a copy of Main
- ExpPrint.hs - Modified to help with Wasm encoding of program graphs
- WasmGCEncode - Encoding of Haskell programs into SK combinator program graphs
