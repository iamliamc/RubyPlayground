require './customer'
require './movie'
require './rental'

m = Movie.new("Happy Gilmore", 0)
m2 = Movie.new("Happy Gilmore 2", 1)

r = Rental.new(m, 2)
r2 = Rental.new(m2, 5)

c = Customer.new("Liam")

c.add_rental(r)
c.add_rental(r2)

puts "Made it to Customer statement"

c.statement
