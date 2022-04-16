!#/usr/bin/env ruby

def welcome(greeting, name='friend', punct='!')
  greeting + ' ' + name + punct
end

puts welcome('Hello', 'neighbor', '!!!')


# A common Ruby pattern is to use an options hash 
# for the most flexibility
def welcome(greeting, options={})
  name = options[:name] || 'friend'
  punct = options[:punct] || '!'
  greeting + ' ' + name + punct
end

puts welcome('Hello', {:punct => '!!!'})
