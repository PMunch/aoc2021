import sequtils, math, strutils

var
  oxynumbers = "input.txt".lines.toSeq
  co2numbers = oxynumbers

template reduce(numbers: untyped, operation: untyped): untyped =
  block:
    var average {.inject.} = 0
    for number in numbers:
      average += (if number[0] == '1': 1 else: 0)
    average = (if average >= (numbers.len div 2): 1 else: 0)

    var i = 0
    while numbers.len != 1:
      var newaverage = 0
      numbers = numbers.filterIt:
        let num {.inject.} = ord(it[i]) - ord('0')
        let keeping = operation
        if keeping and i != it.high:
          newaverage += (if it[i+1] == '1': 1 else: 0)
        keeping
      average = (if newaverage >= round(numbers.len / 2).int: 1 else: 0)
      inc i

oxynumbers.reduce:
  num == average
co2numbers.reduce:
  num != average

echo parseBinInt(oxynumbers[0]) * parseBinInt(co2numbers[0])
