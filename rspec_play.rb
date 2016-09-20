Dir["/Users/liam/dev/RubyPlayground/lib/*.rb"].each {|file| require file }
require 'rspec'
require 'logger'

$count = 0
describe "test" do
  let(:count) { $count += 1 }
  let(:customer) {{name: "Liam"}}

  it "memoizes the value" do
    expect(count).to eq(1)
    expect(count).to eq(1)
  end

  it "is not cached across examples" do
    expect(count).to eq(2)
  end

  it "further proof it is not cached across examples" do
    expect(count).to eq(3)
  end

  it "shows a hash works" do
    expect(customer[:name]).to eq("Liam")
  end
end

describe "test 2" do
  let(:count) {$count}
  it "treats variables locally in describe blocks" do
    expect(count).to eq(3)
  end
end

describe "testing Adtegrity module" do
  let(:friend) {Adtegrity::Friend.new}

  it "initializes correctly" do
    expect(friend.name).to eq("New Employee")
  end

  it "counts friend list length" do
    friend.add(["Liam", "George", "Patty"])
    expect(friend.count_friends).to eq(3)
  end

  it "fails when friends add is not called" do
    expect(friend.count_friends).to eq(0)
  end
end

describe "testing Logger & my ability to read-write files" do
  %x(rm spec.log)
  let(:logger) {Logger.new('spec.log')}
  it "can log correctly" do
    logger.info "General Logging"
    logger.info "More General Logging"
    File.open("spec.log").each_with_index do |line, idx|
      if idx == 1
        expect(/(?<result>INFO -- : (?<answer>.*)\s)/.match(line)["answer"]).to eq("General Logging")
      elsif idx == 2
        expect(/(?<result>INFO -- : (?<answer>.*)\s)/.match(line)["answer"]).to eq("More General Logging")
      end
    end
  end

describe "doing a little stubbing" do
  let(:friend) {Adtegrity::Friend.new}

  it "can stub with args a method with no args" do
    friend.stub(:stub_test) {|arg|
      "This is my arg: #{arg}!"
    }
    expect(friend.stub_test("Hello World")).to eq("This is my arg: Hello World!")
  end

  it "can stub args with different syntax" do
    friend.stub(:stub_test) do |arg1, arg2|
      "This is arg1: #{arg1}, this is arg2: #{arg2}"
    end

    expect(friend.stub_test("Liam", "Considine")).to eq("This is arg1: Liam, this is arg2: Considine")
  end


end

end
