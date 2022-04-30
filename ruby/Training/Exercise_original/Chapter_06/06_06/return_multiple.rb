#!/usr/bin/env ruby

def add_and_subtract(n1, n2)
  add = n1 + n2
  sub = n1 - n2
  [add, sub]
end

result = add_and_subtract(8,3)
a = result[0]
s = result[1]

puts a
puts s

# multiple assignment using comma-delimited list of variables
a, s = add_and_subtract(8,3)

puts a
puts s
