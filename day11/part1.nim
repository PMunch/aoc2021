var octopuses = readFile("input.txt")

proc addEnergy(x, y: int, alreadyFlashed: var set[uint8]) =
  if x < 0 or x > 9 or y < 0 or y > 9: return
  let index = x + y*11
  if index.uint8 in alreadyFlashed: return
  octopuses[index] = (octopuses[index].ord + 1).chr
  if octopuses[index] == ':':
    octopuses[index] = '0'
    alreadyFlashed.incl index.uint8
    addEnergy(x - 1, y - 1, alreadyFlashed)
    addEnergy(x, y - 1, alreadyFlashed)
    addEnergy(x + 1, y - 1, alreadyFlashed)
    addEnergy(x - 1, y, alreadyFlashed)
    addEnergy(x + 1, y, alreadyFlashed)
    addEnergy(x - 1, y + 1, alreadyFlashed)
    addEnergy(x, y + 1, alreadyFlashed)
    addEnergy(x + 1, y + 1, alreadyFlashed)

#echo octopuses
var flashes = 0
for i in 0..99:
  var flashed: set[uint8]
  for x in 0..9:
    for y in 0..9:
      addEnergy(x, y, flashed)
  flashes += flashed.card

echo flashes
#echo octopuses
