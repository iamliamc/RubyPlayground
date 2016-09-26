#if a class has an attr_reader on an instance variable you don't need to use "@"
class Liam
  attr_reader :pin
  def initalize
    @pin = 1234
  end
  def pin_print
    puts pin
  end
end

y = Liam.new
y.pin_print

