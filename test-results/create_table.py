import os
import csv

directory = "./"
result = "results.csv"

wasmgc_files = [f for f in os.listdir(directory) if f.endswith("-wasmgc.wasm")]
curr_row = []

rows = []
for wf in wasmgc_files:
  wf_size = os.path.getsize(directory+wf)

  c_name = wf.removesuffix("-wasmgc.wasm")
  c_size = os.path.getsize(directory+c_name)

  w_name = c_name + ".wasm"
  w_size = os.path.getsize(directory+w_name)

  curr_row = [c_name, wf_size, c_size, w_size]
  rows.append(curr_row)

with open(result, mode="w", newline="") as f:
  writer = csv.writer(f)
  writer.writerows(rows)
  


