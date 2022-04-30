# This file is a transcript of the IRB session shown in the movie.
# You should be able to cut and paste it into IRB to get 
# the same results shown in the comments.

# irb
inclusive = 1..10
# => 1..10
inclusive.class
# => Range
1..10.class
# ArgumentError: bad value for range
# 	from (irb):4
# 	from :0
(1..10).class
# => Range
exclusive = 1...10
# => 1...10
inclusive.include?(10)
# => true
exclusive.include?(10)
# => false
inclusive.begin
# => 1
inclusive.first
# => 1
inclusive.end
# => 10
inclusive.last
# => 10
exclusive.begin
# => 1
exclusive.end
# => 10
array = [*inclusive]
# => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
alpha = 'a'..'m'
# => "a".."m"
alpha.include?('g')
# => true
array = [*alpha]
# => ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m"]
quit
