# This file is a transcript of the IRB session shown in the movie.
# You should be able to cut and paste it into IRB to get 
# the same results shown in the comments.

# irb
'Let\'s escape!'
# => "Let's escape!"
"I said, \"Let's escape!\""
# => "I said, \"Let's escape!.\""
'I said, "Let\'s escape!"'
# => "I said, \"Let's escape!\""
puts "\ta\tb\nc\n\td"
# 	a  b
# c
#   d
# => nil
puts '\ta\tb\nc\n\td'
# \ta\tb\nc\n\td
# => nil
msg = 'I love you'
puts "I just called to say: #{msg}."
# "I just called to say: I love you."
puts 'I just called to say: #{msg}.'
# "I just called to say: #{msg}."
puts "I just called to say: #{msg.upcase}."
# "I just called to say: I LOVE YOU."
puts "1 + 1 = #{1 + 1}"
# 1 + 1 = 2
# => nil
quit
