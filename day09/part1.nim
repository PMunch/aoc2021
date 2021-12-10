import sequtils

var grid: seq[seq[uint8]]

for line in lines("input.txt"):
  grid.add line.mapIt(uint8(it.ord - ord('0')))

var risk = 0
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
      risk += current.int + 1

echo risk
