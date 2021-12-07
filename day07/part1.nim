import strutils, sequtils, terminal

var
  minPos = int.high
  maxPos = 0

let crabs = readFile("input.txt").split(',').mapIt:
  let num = it.strip.parseInt
  minPos = min(num, minPos)
  maxPos = max(num, maxPos)
  num

var leastFuel = int.high
for pos in minPos..maxPos:
  var fuel = 0
  for crab in crabs:
    fuel += abs(pos - crab)
  #echo ".".repeat ((terminalWidth() / 1458457) * fuel.float).int
  leastFuel = min(leastFuel, fuel)

echo leastFuel
