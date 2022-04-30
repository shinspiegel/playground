# This file is a transcript of the IRB session shown in the movie.
# You should be able to cut and paste it into IRB to get 
# the same results shown in the comments.

# irb
array = [2, 4, ['a', 'b'], nil, 4, 'c']
# => [2, 4, ["a", "b"], nil, 4, "c"]
array.length
# => 6
array.size
# => 6
array.reverse
# => ["c", 4, nil, ["a", "b"], 4, 2]
array
# => [2, 4, ["a", "b"], nil, 4, "c"]
array.reverse!
# => ["c", 4, nil, ["a", "b"], 4, 2]
array
# => ["c", 4, nil, ["a", "b"], 4, 2]
array.shuffle
# => [4, "c", 4, 2, nil, ["a", "b"]]
array.shuffle
# => [4, 2, ["a", "b"], 4, nil, "c"]
array.shuffle!
# => ["c", 4, ["a", "b"], nil, 2, 4]
array.uniq
# => ["c", 4, ["a", "b"], nil, 2]
array.uniq!
# => ["c", 4, ["a", "b"], nil, 2]
array.compact
# => ["c", 4, ["a", "b"], 2]
array.compact!
# => ["c", 4, ["a", "b"], 2]
array.flatten
# => ["c", 4, "a", "b", 2]
array.flatten!
# => ["c", 4, "a", "b", 2]
array.include?(2)
# => true
array.include?(1)
# => false
array.delete_at(1)
# => 4
array
# => ["c", "a", "b", 2]
array.delete('c')
# => "c"
array
# => ["a", "b", 2]
[1,2,3,4].join(',')
# => "1,2,3,4"
[1,2,3,4].join
# => "1234"
[1,2,3,4].join(' - ')
# => "1 - 2 - 3 - 4"
"1,2,3,4".split(',')
# => ["1", "2", "3", "4"]
numbers = [1,2,3,4]
# => [1, 2, 3, 4]
numbers.push(5)
# => [1, 2, 3, 4, 5]
last = numbers.pop
# = 5
numbers
# => [1, 2, 3, 4]
first = numbers.shift
# 1
numbers
# => [2, 3, 4]
numbers.unshift(1)
# => [1, 2, 3, 4]
quit
