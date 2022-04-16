a = [1, 2, 3, 4]

puts "#{a.join(",")}"

def thing(a)
  a.shuffle!
end

thing a

puts "#{a.join(",")}"
