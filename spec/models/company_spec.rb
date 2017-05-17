require_relative './../spec_helper.rb'

RSpec.describe Company, :type => :model do
  end
  it "is valid with valid attributes" do
    expect(Company.new(name: FFaker::Name.name)).to be_valid
  end
  it "is not valid without a name" do
    expect(Company.new()).to_not be_valid
  end
end
