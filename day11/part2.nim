var octopuses = readFile("input.txt")

proc addEnergy(x, y: int, alreadyFlashed: var set[uint8]) =
  if x < 0 or x > 9 or y < 0 or y > 9: return
  let index = x + y*11
  if index.uint8 in alreadyFlashed: return
  octopuses[index] = (octopuses[index].ord + 1).chr
  if octopuses[index] == ':':
    octopuses[index] = '0'
    alreadyFlashed.incl index.uint8
    for yi in -1..1:
      for xi in -1..1:
        addEnergy(x + xi, y + yi, alreadyFlashed)

var i = 0
while true:
  inc i
  var flashed: set[uint8]
  for x in 0..9:
    for y in 0..9:
      addEnergy(x, y, flashed)
  if flashed.card == 100:
    echo i
    break
