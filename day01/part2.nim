import strutils

var
  increased = 0
  last = int.high
  seenvalues: array[3, int]
  sum = 0
  i = 0

for line in "input.txt".lines:
  var depth = parseInt(line)
  sum += depth
  if i > 2:
    sum -= seenvalues[(i - 3) mod 3]
    if sum > last:
      inc increased
  last = sum
  seenvalues[i mod 3] = depth
  inc i

echo increased
