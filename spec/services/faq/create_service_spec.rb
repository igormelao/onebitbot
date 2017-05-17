require_relative './../../spec_helper.rb'

describe FaqModule::CreateService do

  before do
    @company  = create(:company)
    @question = FFaker::Lorem.sentence
    @answer   = FFaker::Lorem.sentence
    @hashtags = "#{FFaker::Lorem.word}, #{FFaker::Lorem.word}"
  end

  describe '#call' do
    it "with valid params, receive success message" do
      createService = FaqModule::CreateService.new("question.original" => @question, "answer.original" => @answer, "hashtags.original" => @hashtags)

      response = createService.call()

      expect(response).to eq("Created with success!")

      @faq = Faq.last
      @hashtags_created = Hashtag.all

      expect(@faq.nil?).to eq(false)
      expect(@faq.company.name).to eq(@company.name)
      expect(@faq.question).to eq(@question)
      expect(@faq.answer).to eq(@answer)
      expect(@faq.hashtags.empty?).to eq(false)
      expect(@faq.hashtags.length).to eq(2)
      expect(@faq.hashtags.first.name).to eq(Hashtag.first.name)
      expect(@faq.hashtags.second.name).to eq(Hashtag.second.name)
    end

    it "without hashtag params, receive error message" do
      createService = FaqModule::CreateService.new("question.original" => @question, "answer.original" => @anser)

      response = createService.call()

      expect(response).to eq("Hashtag is required!")
      expect(Faq.last).to eq(nil)
      expect(Hashtag.last).to eq(nil)
    end

    it "with error, receive error message" do
      createService = FaqModule::CreateService.new("question.original" => @question,"hashtags.original" => @hashtags)

      response = createService.call()

      expect(response).to eq("Ops! I'm sorry, but during the process of Faq creation occurred error Validation failed: Answer can't be blank. Contact us to resolve this problem! We will be glad to help you!")
    end
  end
end
