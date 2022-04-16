# This file is a transcript of the IRB session shown in the movie.
# You should be able to cut and paste it into IRB to get 
# the same results shown in the comments.

# irb
[1,2,3,4,5].inject {|memo, n| memo + n}
# => 15
[1,2,3,4,5].inject {|memo, n| memo * n}
# => 120
[1,2,3,4,5].inject {|memo, n| memo ** n}
# => 1
[2,3,4,5].inject {|memo, n| memo ** n}
# => 1152921504606846976
fruits = ['apple', 'banana', 'pear', 'orange']
# => ["apple", "banana", "pear", "orange"]
longest = fruits.inject do |memo, fruit|
  if fruit.length > memo.length
    fruit
  else
    memo
  end
end
# => "banana"
quit


