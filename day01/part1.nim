import strutils

var
  increased = 0
  last = int.high

for line in "input.txt".lines:
  var depth = parseInt(line)
  if depth > last:
    inc increased
  last = depth

echo increased
