import strscans, tables, hashes

var
  counts: CountTable[tuple[x, y: int]]
  manyVents = 0

proc countSpot(x, y: int) =
  counts.inc (x, y)
  if counts[(x, y)] == 2:
    inc manyVents

for line in lines "hardcore.input":
  let (success, startX, startY, stopX, stopY) = scanTuple(line, "$i,$i -> $i,$i")
  if not success: quit 1
  let transformation =
    (x:
      if startX == stopX: 0
      elif startX > stopX: -1
      else: 1,
    y:
      if startY == stopY: 0
      elif startY > stopY: -1
      else: 1)

  var
    x = startX
    y = startY

  countSpot(startX, startY)
  while x != stopX or y != stopY:
    x += transformation.x
    y += transformation.y
    countSpot(x, y)

echo manyVents
