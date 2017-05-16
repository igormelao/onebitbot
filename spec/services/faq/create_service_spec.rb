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

      expect(response).to eq("Criado com sucesso!")

      @faq = Faq.last
      @hashtags_created = Hashtag.all

      expect(@faq.nil?).to eq(false)
      expect(@faq.company.name).to eq(@company.name)
      expect(@faq.question).to eq(@question)
      expect(@faq.answer).to eq(@answer)
      expect(@faq.hashtags.empty?).to eq(false)
      expect(@faq.hashtags.length).to eq(2)

      expect(@hashtags_created.empty?).to eq(false)
      expect(@hashtags_created.length).to eq(2)
    end

    it "without hashtag params, receive alert message" do
      createService = FaqModule::CreateService.new("question.original" => @question, "answer.original" => @anser)

      response = createService.call()

      expect(response).to eq("A Hashtag é obrigatoria!")
      expect(Faq.last).to eq(nil)
      expect(Hashtag.last).to eq(nil)
    end
  end
end
