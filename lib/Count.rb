module Count
  def self.add(a)
    val = 0
    a.each {|v| val+= v}
    val
  end
end
