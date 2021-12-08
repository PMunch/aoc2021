import strutils

iterator outputs(file: string): seq[string] =
  for line in file.lines:
    yield line.split(" | ")[1].split(' ')

var count = 0
for output in outputs("input.txt"):
  for digit in output:
    case digit.len:
    of 2, 3, 4, 7: inc count
    else: continue

echo count
