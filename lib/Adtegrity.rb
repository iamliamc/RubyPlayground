module Adtegrity
  class Friend
    attr_accessor :name, :friends_list

    def initialize
      @friends_list = []
      @name = "New Employee"
    end

    def count_friends
      @friends_list.length
    end
    
    def show
      @friends_list.each{|f| puts f}
    end

    def add(friends = [])
      Array(friends).each{|f| @friends_list.push(f)}
    end

    def remove(remove_list = [])
      #remove_list.each{|r| @friends_list.delete(r)}
      for r in remove_list
        if @friends_list.delete(r)
          puts "#{r} removed from Friends List!"
        else
          puts "#{r} wasn't a valid Friends List Entry!"
        end
      end
    end
  end
end
