import strutils, algorithm, sequtils

proc toSet(x: string): set[char] =
  for c in x:
    result.incl c
  result

iterator outputs(file: string): tuple[segment, output: seq[set[char]]] =
  for line in file.lines:
    let pair = line.split(" | ")
    yield (pair[0].split(' ').sorted(proc (x, y: string): int = x.len - y.len).map(toSet),
           pair[1].split(' ').map(toSet))

var count = 0
for output in outputs("input.txt"):
  var digits: array[0..9, set[char]]
  digits[1] = output.segment[0]
  digits[7] = output.segment[1]
  digits[4] = output.segment[2]
  digits[8] = output.segment[9]
  for i in 6..8:
    if (output.segment[i] - digits[1]).card == 5:
      digits[6] = output.segment[i]
    elif (output.segment[i] - digits[4]).card == 2:
      digits[9] = output.segment[i]
    else:
      digits[0] = output.segment[i]
  for i in 3..5:
    if (output.segment[i] - digits[1]).card == 3:
      digits[3] = output.segment[i]
    elif (output.segment[i] - digits[9]).card == 0:
      digits[5] = output.segment[i]
    else:
      digits[2] = output.segment[i]

  var num = 0
  for digit in output.output:
    for i in 0..9:
      if digits[i] == digit:
        num = num*10 + i

  count += num

echo count
