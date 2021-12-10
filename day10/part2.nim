import algorithm

type
  IncompleteLineError = object of CatchableError
    completionString: string
  InvalidLineError = object of CatchableError
    invalidChar: char

proc newInvalidLineError(message: string, invalidChar: char): ref InvalidLineError =
  result = newException(InvalidLineError, message)
  result.invalidChar = invalidChar

proc newIncompleteLineError(message: string): ref IncompleteLineError =
  result = newException(IncompleteLineError, message)

proc addCompletion(error: ref IncompleteLineError, completionChar: char): ref IncompleteLineError =
  result = error
  result.completionString.add completionChar

proc matchBracket(data: string, pos: int): int =
  var pos = pos
  if pos > data.high:
    raise newIncompleteLineError("Reached end of line before termination")
  let endChar =
    case data[pos]:
    of '(': ')'
    of '[': ']'
    of '{': '}'
    of '<': '>'
    else: raise newInvalidLineError("Found unexpected bracket", data[pos])
  pos.inc
  while pos > data.high or data[pos] != endChar:
    try:
      pos = matchBracket(data, pos)
    except IncompleteLineError as e:
      raise e.addCompletion(endChar)
  pos.inc
  return pos

var
  part1score = 0
  part2scores: seq[int]

for line in "input.txt".lines:
  try:
    var pos = 0
    while pos != line.len:
      pos = matchBracket(line, pos)
    assert pos == line.len
  except IncompleteLineError as e:
    var score = 0
    for c in e.completionString:
      score *= 5
      score +=
        (case c:
        of ')': 1
        of ']': 2
        of '}': 3
        of '>': 4
        else: 0)
    part2scores.add score
  except InvalidLineError as e:
    part1score +=
      (case e.invalidChar:
      of ')': 3
      of ']': 57
      of '}': 1197
      of '>': 25137
      else: 0)

echo part1score
echo part2scores.sorted[part2scores.len div 2]
