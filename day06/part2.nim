import strutils, sequtils

var fishList: array[0..9, int]
for fish in readFile("input.txt").split(',').mapIt(it.strip.parseInt):
  fishList[fish] += 1

for i in 0..255:
  fishList[9] += fishList[0]
  for i in 0..8:
    fishList[i] = fishList[i+1]
  fishList[6] += fishList[9]
  fishList[9] = 0

var count = 0
for i in fishList:
  count += i

echo count
