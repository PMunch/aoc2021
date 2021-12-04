import strutils, streams, sequtils

let
  input = newFileStream("input.txt")
  numbers = input.readLine.split(',').map(parseInt)

type
  BoardLine = array[5, int]
  Board = array[5, BoardLine]
  ScoreBoard = array[5, array[5, bool]]

converter toBoardLine(x: seq[int]): BoardLine =
  assert x.len == 5
  copyMem(result[0].addr, x[0].unsafeAddr, sizeof(BoardLine))
  #for i in 0..4:
  #  result[i] = x[i]

proc `$`(x: Board): string =
  for line in x:
    for column in line:
      result &= align($column, 3)
    result &= "\n"

proc `$`(x: seq[Board]): string =
  for board in x:
    result &= $board & "\n"

var boards: seq[Board]

while not input.atEnd:
  discard input.readLine
  var newBoard: Board
  for i in 0..4:
    newBoard[i] = input.readLine.splitWhitespace.map(parseInt)
  boards.add newBoard

echo numbers
echo boards
input.close()

var scores = newSeq[ScoreBoard](boards.len)

proc checkBoard(i, ix, iy: int): bool =
  result = true
  for x in 0..4:
    if not scores[i][iy][x]:
      result = false
      break

  if result: return

  result = true
  for y in 0..4:
    if not scores[i][y][ix]:
      result = false
      break

proc scoreBoard(i: int): int =
  for y, line in boards[i]:
    for x, column in line:
      if not scores[i][y][x]:
        result += column

var completedBoards: set[uint16]

for number in numbers:
  for i, board in boards:
    if i.uint16 in completedBoards: continue
    for y, line in board:
      for x, column in line:
        if column == number:
          scores[i][y][x] = true
          if checkBoard(i, x, y):
            completedBoards.incl i.uint16
            if completedBoards.card == boards.len:
              echo scoreBoard(i) * number
              quit 0
