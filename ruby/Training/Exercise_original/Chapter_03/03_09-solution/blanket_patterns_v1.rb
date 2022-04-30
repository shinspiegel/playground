# Blanket Patterns Solution 1
# Uses a loop
# Changes the start of the new string without modifying the original string
# Integer#modulo divides a number by another and returns the remainder

colors = "RRGGBBYYKK"
lines = 20

count = 0
while count < lines
  start = count.modulo(colors.length)
  first_half = colors[start..-1]
  second_half = colors[0...start]
  puts first_half + second_half
  count += 1
end
