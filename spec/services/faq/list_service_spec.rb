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
      listService = FaqModule::ListService.new({'queyr' => ''}, 'search')

      response = listService.call()
      expect(response).to match("Nada encontrado")
    end
  end
end
