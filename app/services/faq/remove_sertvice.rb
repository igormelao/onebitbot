module FaqModule
  class RemoveService
    def initialize(params)
      @id = params["id"]
    end

    def call
      faq = Company.last.faqs.where(id: @id).last
      return "Questão inválida, por favor verifique o Id" if faq.nil?

      Faq.transaction do
        faq.hashtags.each do |hashtag|
          hashtag.delete if hashtag.faqs.count <= 1
        end
        faq.delete
        "Deletado com sucesso"
      end
    end
  end
end
