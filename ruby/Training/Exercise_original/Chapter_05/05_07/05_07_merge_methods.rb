# This file is a transcript of the IRB session shown in the movie.
# You should be able to cut and paste it into IRB to get 
# the same results shown in the comments.

# irb
h1 = {:a => 2, :b => 4, :c => 6}
# => {:a=>2, :b=>4, :c=>6}
h2 = {:a => 3, :b => 4, :d => 8}
# => {:a=>3, :b=>4, :d=>8}
h1.merge(h2)
# => {:a=>3, :b=>4, :c=>6, :d=>8}
h2.merge(h1)
# => {:a=>2, :b=>4, :d=>8, :c=>6}
h1.merge(h2) {|k,o,n| o }
# => {:a=>2, :b=>4, :c=>6, :d=>8}
h1.merge(h2) {|k,o,n| o * 100 }
# => {:a=>200, :b=>400, :c=>6, :d=>8}
quit
