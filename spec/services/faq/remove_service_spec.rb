require_relative './../../spec_helper.rb'

describe FaqModule::RemoveService do
  describe " #call" do
    it "with valid ID, remove Faq" do
      company = create(:company)
      faq = create(:faq, company: company)
      hashtag = create(:hashtag, company: company)
      create(:faq_hashtag, faq: faq, hashtag: hashtag)

      removeService = FaqModule::RemoveService.new({"id" => faq.id})
      response = removeService.call()

      expect(response).to match("Deletado com sucesso")
      expect(Faq.count).to eq(0)
      expect(Hashtag.count).to eq(0)
    end

    it "with invalid ID, return message error" do
        company = create(:company)
        faq = create(:faq, company: company)

        removeService = FaqModule::RemoveService.new({"id" => 22})
        response = removeService.call()

        expect(response).to match("Questão inválida, por favor verifique o Id")
        expect(Faq.count).to eq(1)
    end
  end
end
