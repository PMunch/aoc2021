import strutils, sequtils

var fishList = readFile("input.txt").split(',').mapIt(it.strip.parseInt)

for i in 0..79:
  for i in 0..fishList.high:
    template fish: int = fishList[i]
    if fish == 0:
      fishList.add 8
      fish = 6
    else: fish -= 1

echo fishList.len
