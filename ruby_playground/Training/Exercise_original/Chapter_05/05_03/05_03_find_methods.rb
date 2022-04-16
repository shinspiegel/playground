# This file is a transcript of the IRB session shown in the movie.
# You should be able to cut and paste it into IRB to get 
# the same results shown in the comments.

# irb --simple-prompt
x = (1..10).find {|n| n == 5}
# => 5
x = (1..10).find {|n| n % 3 == 0}
# => 3
x = (1..10).detect {|n| n % 3 == 0}
# => 3
fruits = ['apple', 'banana', 'pear']
# => ['apple', 'banana', 'pear']
fruits.find {|fruit| fruit.length > 5}
# => "banana"
pantry = {'apple' => 0, 'banana' => 1, 'pear' => 3}
# => {'apple' => 0, 'banana' => 1, 'pear' => 3}
pantry.find {|k,v| v == 0}
# ["apple", 0]
(1..10).find_all {|n| n % 3 == 0}
# [3,6,9]
(1..10).select {|n| n % 3 == 0}
# [3,6,9]
(1..10).any? {|n| n <= 5}
# => true
(1..10).none? {|n| n <= 5}
# => false
(1..10).all? {|n| n <= 5}
# => false
(1..10).one? {|n| n <= 5}
# => false
(1..10).one? {|n| n == 5}
# => true
numbers = [*1..10]
# => [1,2,3,4,5,6,7,8,9,10]
numbers.delete_if {|n| n <= 5}
# => [6, 7, 8, 9, 10]
numbers
# => [6, 7, 8, 9, 10]
numbers = [*1..10]
# => [1,2,3,4,5,6,7,8,9,10]
evens = numbers.delete_if {|n| n % 2 == 1}
# => [2, 4, 6, 8, 10]
quit
