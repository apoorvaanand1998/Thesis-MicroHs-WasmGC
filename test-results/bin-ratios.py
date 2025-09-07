import os
import csv

directory = "./"
result = "binSizes.csv"

wasmgc_files = [f for f in os.listdir(directory) if f.endswith("-wasmgc.wasm")]

rows = []
for wf in wasmgc_files:
  wf_size = os.path.getsize(directory+wf)
  name    = wf.removesuffix("-wasmgc.wasm")
  wat_size = os.path.getsize(directory+name+"-wasmgc.wat")
  rows.append([name, wf_size, wat_size])

with open(result, mode="w", newline="") as f:
  writer = csv.writer(f)
  writer.writerows(rows)
