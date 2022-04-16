#!/usr/bin/env ruby

def volume(x,y,z)
  x * y * z
end

puts volume(2,3,4)

puts volume(5,6,7)

# Number of arguments matters
# puts volume(2,3)


# Order of arguments matters
def welcome(greeting, target)
  puts "#{greeting} #{target}!"
end


welcome('Hello', 'world')

welcome('world', 'Hello')
