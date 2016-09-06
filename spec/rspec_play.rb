require 'rspec'
#require 'spec_helper'

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
