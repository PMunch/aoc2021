import strutils

var
  x = 0
  depth = 0

for command in "input.txt".lines:
  let
    split = command.split(' ')
    direction = split[0]
    amount = parseInt(split[1])
  case direction:
  of "forward":
    x += amount
  of "up":
    depth -= amount
  of "down":
    depth += amount

echo x * depth
