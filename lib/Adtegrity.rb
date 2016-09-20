module Adtegrity
  class Friend
    attr_accessor :name, :friends_list

    def self.call(*args)
      new(*args).call
    end

    def initialize(friends_list = [], name = "New Employee")
      @friends_list = friends_list
      @name = name
    end

    def call
      puts "I've been called"
      self.show
    end

    def count_friends
      @friends_list.length
    end

    def stub_test
      "This is a stub test!"
    end

    def show
      #can reference friends_list without @friends_list due to attr_accessor on that value
      friends_list.each{|f| puts f}
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
