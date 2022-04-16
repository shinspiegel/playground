# This file is a transcript of the IRB session shown in the movie.
# You should be able to cut and paste it into IRB to get 
# the same results shown in the comments.

# irb
x = [1,2,3,4,5]
# => [1, 2, 3, 4, 5]
y = x.map {|n| n * 50 }
# => [50, 100, 150, 200, 250]
x
# => [1, 2, 3, 4, 5]
y
# => [50, 100, 150, 200, 250]
x.map! {|n| n * 50 }
# => [50, 100, 150, 200, 250]
x
# => [50, 100, 150, 200, 250]
fruits = ['apple', 'banana', 'pear']
# => ["apple", "banana", "pear"]
cap_fruits = fruits.map do |fruit|
  fruit.capitalize if fruit == 'pear'
end
# => [nil, nil, "Pear"]
cap_fruits = fruits.map do |fruit|
  fruit == 'pear' ? fruit.capitalize : fruit
end
# => ["apple", "banana", "Pear"]
quit
