require_relative "./../spec_helper.rb"

RSpec.describe Faq, :type => :model do
  before do
    @company = Company.new(name: FFaker::Name.name)
    @question = FFaker::Lorem.sentence
    @answer = FFaker::Lorem.sentence
    @faq = Faq.new(company: @company,question: @question, answer: @answer)
  end

  it "is valid with valid attributes" do
    expect(@faq).to be_valid
  end

  it "is not valid without a question" do
    @faq.question = nil
    expect(@faq).to_not be_valid
  end
  it "is not valid without a answer" do
    @faq.answer = nil
    expect(@faq).to_not be_valid
  end
end
