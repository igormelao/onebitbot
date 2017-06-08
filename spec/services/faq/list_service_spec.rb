require_relative './../../spec_helper.rb'

describe FaqModule::ListService do
  describe '#call' do

    before do
      @company = create(:company)
    end

    it "with list command: With zero faqs, return don't find message" do
      @listService = FaqModule::ListService.new({}, 'list')

      response = @listService.call()
      expect(response).to match('Nada encontrado')
    end

    it "find faqs with yours questions and answer" do
      faq = create(:faq, company: @company)

      listService = FaqModule::ListService.new({}, 'list')

      response = listService.call();

      expect(response).to match(faq.question)
      expect(response).to match(faq.answer)
    end

    it "with search command and empty query, return dont' find message" do
      listService = FaqModule::ListService.new({'query' => ''}, 'search')

      response = listService.call()
      expect(response).to match("Nada encontrado")
    end

    it "with search command and valid query, return question and answer searched in response" do
      faq = create(:faq, company: @company)

      listService = FaqModule::ListService.new({'query' => faq.question.split(" ").sample}, 'search')

      response = listService.call()

      expect(response).to match(faq.question)
      expect(response).to match(faq.answer)
    end

    it "with search_by_hashtag command and invalid hashtag, return don't find message" do
      listService = FaqModule::ListService.new({'query' => ''}, 'search_by_hashtag')

      response = listService.call()

      expect(response).to match("Nada encontrado")
    end

    it "with search_by_hashtag command and valid hashtag, return question and answer searched in response" do
      faq = create(:faq, company: @company)
      hashtag = create(:hashtag, company: @company)
      create(:faq_hashtag, faq: faq, hashtag: hashtag)
      faq2 = create(:faq, question: "Test", company: @company)

      listService = FaqModule::ListService.new({'query' => hashtag.name}, 'search_by_hashtag')

      response = listService.call()

      expect(response).to match(faq.question)
      expect(response).to match(faq.answer)
      expect(response).not_to match(faq2.question)
    end
  end
end
