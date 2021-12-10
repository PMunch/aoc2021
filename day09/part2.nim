import sequtils, sets, algorithm

type Position = tuple[x, y: int]

var grid: seq[seq[uint8]]

for line in lines("input.txt"):
  grid.add line.mapIt(uint8(it.ord - ord('0')))

func basin(x, y: int, basinPoints: HashSet[Position], grid: seq[seq[uint8]]): HashSet[Position] =
  result = basinPoints
  if grid[y][x] == 9 or basinPoints.contains (x, y): return
  result.incl (x, y)
  if y > 0:
    result.incl basin(x, y-1, result, grid)
  if y < grid.high:
    result.incl basin(x, y+1, result, grid)
  if x > 0:
    result.incl basin(x-1, y, result, grid)
  if x < grid[0].high:
    result.incl basin(x+1, y, result, grid)

template basin(x, y: int): HashSet[Position] =
  basin(x, y, initHashSet[Position](), grid)

var basins: seq[int]
for y in 0..grid.high:
  for x in 0..grid[0].high:
    let current = grid[y][x]
    block check:
      if y > 0:
        if grid[y-1][x] <= current:
          break check
      if y < grid.high:
        if grid[y+1][x] <= current:
          break check
      if x > 0:
        if grid[y][x-1] <= current:
          break check
      if x < grid[0].high:
        if grid[y][x+1] <= current:
          break check
      let basinSize = basin(x, y).card
      basins.add basinSize

basins.sort
echo basins[^1] * basins[^2] * basins[^3]
