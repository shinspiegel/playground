#!/usr/bin/env ruby

MAX_NUMBER = 10
MAX_GUESSES = 3

puts "We are going to play a guessing game."
puts "I will choose a random number between 1 and #{MAX_NUMBER}"
puts "and you will have #{MAX_GUESSES} chances to guess it."

number = rand(MAX_NUMBER) + 1
puts "Okay, I have my number."

1.upto(MAX_GUESSES) do |guess_num|
  print "Guess #{guess_num}: "
  guess = gets.chomp.to_i

  case
  when guess == number
    puts "Great guessing, #{name}!"
    puts "My number was #{number}."
    break
  when guess < number
    puts "This is too lower"
  when guess > number
    puts "This is too higher"
  end

  if guess_num == MAX_GUESSES
    puts
    puts "That was your last guess."
    puts "My number was #{number}."
  end
end

puts "\n\nGoodbye!"
