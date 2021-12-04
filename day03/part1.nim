var
  count: array[12, int]
  lineCount = 0

for line in "input.txt".lines:
  for i, c in line:
    count[i] += (if c == '1': 1 else: 0)
  inc lineCount

var gammaRate = 0
for value in count:
  gammaRate = (gammaRate shl 1) or (if value > (lineCount div 2): 1 else: 0)

var epsilonRate = (not gammaRate) and 0x0fff

echo gammaRate
echo epsilonRate
echo gammaRate * epsilonRate
