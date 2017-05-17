require_relative './../spec_helper.rb'

RSpec.describe Company, :type => :model do
  before do
    @company = Company.new(name: FFaker::Name.name)
  end

  it "is valid with valid attributes" do
    expect(@company).to be_valid
  end

  it "is not valid without a name" do
    @company.name = nil
    expect(@company).to_not be_valid
  end
end
