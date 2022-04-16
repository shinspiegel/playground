# Blanket Patterns Solution 2
# Uses an iterator
# Modifies the string by moving first character to the end

colors = "RRGGBBYYKK"
lines = 20

lines.times do |i|
  first = colors[0]
  rest = colors[1..-1]
  colors = rest + first
  puts colors
end
