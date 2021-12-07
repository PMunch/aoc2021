import strutils, sequtils, terminal, math

var
  minPos = int.high
  maxPos = 0

let crabs = readFile("input.txt").split(',').mapIt:
  let num = it.strip.parseInt
  minPos = min(num, minPos)
  maxPos = max(num, maxPos)
  num

var leastFuel = Inf
for pos in minPos..maxPos:
  var fuel = 0.0
  for crab in crabs:
    let dist = abs(pos - crab).float
    if dist != 0:
      fuel += (dist + 1) * (dist / 2)
  #echo ".".repeat ((terminalWidth() / 1161136304) * fuel).int
  leastFuel = min(leastFuel, fuel)
  #if fuel > leastFuel: break

echo leastFuel
