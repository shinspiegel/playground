# This file is a transcript of the IRB session shown in the movie.
# You should be able to cut and paste it into IRB to get 
# the same results shown in the comments.

# irb
"test".object_id
# => 70287715030480
"test".object_id
# => 70287714953440
:test.object_id
# => 371228
:test.object_id
# => 371228
person = {:first_name => 'Benjamin', :last_name => 'Franklin'}
# => {:first_name => "Benjamin", :last_name => "Franklin"}
person[:first_name]
# => "Benjamin"
person['first_name']
# => nil
shorthand = {first_name: 'Benjamin', last_name: 'Franklin'}
# => {:first_name => "Benjamin", :last_name => "Franklin"}
quit

# RoR has a special mechanism that allows you to refer to values with either a symbol or string, but that's RoR, not Ruby.