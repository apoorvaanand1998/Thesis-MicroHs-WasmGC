import os
import csv
import re

directory = "./"
result = "metric.csv"

wasmgc_files = [f for f in os.listdir(directory) if f.endswith("-wasmgc.wat")]

pattern = r'\(i32\.const -1\)\(ref\.i31\).*(?!\(struct\.new \$value\))\(struct\.new \$appNode\)'
rows = []
for wf in wasmgc_files:
    with open (directory+wf, 'r', encoding='utf-8') as f:
        content = f.read()
        anCount = content.count("struct.new $appNode")
        vCount  = content.count("struct.new $value") ## not implemented value
        tCount  = len(re.findall(pattern, content)) ## not implemented tag

        rows.append([wf, tCount, vCount, anCount, tCount/anCount, vCount/anCount, (vCount+tCount)/anCount])

with open(result, mode="w", newline="") as f:
    w = csv.writer(f)
    w.writerows(rows)
