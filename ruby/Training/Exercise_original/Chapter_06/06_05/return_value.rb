#!/usr/bin/env ruby

def subtract(n1, n2)
  n1 - n2
end

puts subtract(8,3)

# Consider final operation value carefully
# especially operations that return nil
def subtract(n1, n2)
  result = n1 - n2
  result = 0 if result < 0
end

puts subtract(8,3)

# don't use puts/print in most methods
def longest_word(words=[])
  longest = words.inject do |memo, word|
    memo.length > word.length ? memo : word
  end
  puts longest
end

fruits = ['apple','banana','pear','plum'] 
# puts longest_word(fruits)

# puts "I ate a #{longest_word(fruits)}."
