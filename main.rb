Dir["/Users/liam/dev/RubyPlayground/lib/*.rb"].each {|file| require file }

puts "Creating 3 Friend Objects"
person = Adtegrity::Friend.new
person2 = Adtegrity::Friend.new
person3 = Adtegrity::Friend.new

puts "Adding friends to Friend Objects"
person.add(["Liam", "George", "Patty"])
person2.add(["Tony", "Bill"])
person3.add(["Sam", "Erica"])

puts "Load module Count, get total friends should be 7"
puts Count.add([person.count_friends, person2.count_friends, person3.count_friends])

buzz = Phone.new
puts buzz.number
