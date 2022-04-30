# Blanket Patterns Solution 3
# Uses an iterator
# Converts the string to an array
# Then modifies array by moving first object to end

colors = "++*~~*++*"
lines = 20

colors_array = colors.split('')
1.upto(lines) do |i|
  first = colors_array.shift
  colors_array << first
  puts colors_array.join
end
