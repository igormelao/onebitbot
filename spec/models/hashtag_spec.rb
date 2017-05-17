require_relative "./../spec_helper.rb"

RSpec.describe Hashtag, :type => :model do
  before do
    @company = Company.new(name: FFaker::Name.name)
    @hashtag = Hashtag.new(name: FFaker::Lorem.word,company: @company)
  end
  it "is valid with valid attributes" do
    expect(@hashtag).to be_valid
  end

  it "is not valid without a name" do
    @hashtag.name = nil
    expect(@hashtag).to_not be_valid
  end
end
