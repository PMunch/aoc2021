import strscans, tables

var
  counts: CountTable[tuple[x, y: int]]
  manyVents = 0

proc countSpot(x, y: int) =
  counts.inc (x, y)
  if counts[(x, y)] == 2:
    inc manyVents

for line in lines "input.txt":
  let (success, startX, startY, stopX, stopY) = scanTuple(line, "$i,$i -> $i,$i")
  if not success: quit 1
  if startX == stopX:
    for y in min(startY, stopY)..max(startY, stopY):
      countSpot(startX, y)
  if startY == stopY:
    for x in min(startX, stopX)..max(startX, stopX):
      countSpot(x, startY)

echo manyVents
