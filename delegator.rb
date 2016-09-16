class Person
  attr_accessor :name, :fav_color

  def initialize(name, fav_color)
    self.name = name
    self.fav_color = fav_color
  end

end

class OtherPerson
  attr_accessor :name, :least_fav_color

  def initialize(name, least_fav_color)
    self.name = name
    self.least_fav_color = least_fav_color
  end
end

class AnyPerson < SimpleDelegator

  def color
    if __getobj__.respond_to?(:fav_color)
      puts self.fav_color
    elsif __getobj__.respond_to?(:least_fav_color)
      puts self.least_fav_color
    else
      puts "I don't know this object"
    end
  end

  def whatAmI
    puts __getobj__.class.name
    puts "My Methods are:"
    (__getobj__.methods - Object.methods).each {|m| puts m}
  end
end


p = Person.new("Liam", "Blue")
op = OtherPerson.new("George", "Red")

a1 = AnyPerson.new(p)
a1.whatAmI
puts a1.name
a1.color
a2 = AnyPerson.new(op)
a2.whatAmI
puts a2.name
a2.color
