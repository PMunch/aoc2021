type
  IncompleteLineError = object of Defect
  InvalidLineError = object of Defect
    invalidChar: char

proc newInvalidLineError(message: string, invalidChar: char): ref InvalidLineError =
  result = newException(InvalidLineError, message)
  result.invalidChar = invalidChar

proc matchBracket(data: string, pos: int): int =
  var pos = pos
  if pos > data.high:
    raise newException(IncompleteLineError, "Reached end of line before termination")
  let endChar =
    case data[pos]:
    of '(': ')'
    of '[': ']'
    of '{': '}'
    of '<': '>'
    else: raise newInvalidLineError("Found unexpected bracket", data[pos])
  pos.inc
  while pos > data.high or data[pos] != endChar:
    pos = matchBracket(data, pos)
  pos.inc
  return pos

var score = 0

for line in "input.txt".lines:
  try:
    var pos = 0
    while pos != line.len:
      pos = matchBracket(line, pos)
    assert pos == line.len
  except IncompleteLineError:
    discard
  except InvalidLineError as e:
    score +=
      (case e.invalidChar:
      of ')': 3
      of ']': 57
      of '}': 1197
      of '>': 25137
      else: 0)

echo score
