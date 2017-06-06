module FaqModule
  class ListService
    def initialize(params,action)
      @company = Company.last
    end

    def call
      faqs = Company.last.faqs
      response = "*Perguntas e Respostas* \n\n"
      faqs.each do |f|
        response += "*#{ f.id }* - "
        response += "*#{ f.question }*\n"
        response += ">#{ f.answer }\n"
        f.hashtags.each do |h|
          response +="_##{ h.name }"
        end
        response += "\n\n"
      end

      (faqs.count > 0) ? response : "Nada encontrado"
    end
  end
end
