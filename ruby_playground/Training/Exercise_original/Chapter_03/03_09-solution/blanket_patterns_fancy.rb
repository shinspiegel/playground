# Blanket Patterns Fancy
# Similar to Solution 3
# Changes characters at halfway point
# Reverses direction after halfway point

colors = "=|/|/|=|/|"
lines = 20
halfway = (lines / 2).floor

colors_array = colors.split('')

# output first half
1.upto(halfway) do |i|
  first = colors_array.shift
  colors_array << first
  puts colors_array.join
end

# Swap characters and output the result
colors_array.length.times do |x|
  if colors_array[x] == '/'
    colors_array[x] = '\\'
  end
end
puts colors_array.join

# output second half
halfway.upto(lines) do |i|
  last = colors_array.pop
  colors_array.unshift(last)
  puts colors_array.join
end
