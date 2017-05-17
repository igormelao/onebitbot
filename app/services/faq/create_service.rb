module FaqModule

  class CreateService

    def initialize(params)
      @company  = Company.last
      @question = params["question.original"]
      @answer   = params["answer.original"]
      @hashtags = params["hashtags.original"]
    end

    def call()
      return "Hashtag is required!" if @hashtags.nil? || @hashtags.empty?
      begin
        Faq.transaction do
          faq = Faq.create!(question: @question,
                            answer:   @answer,
                            company:  @company)

          @hashtags.split(/[\s,]+/).each do |hashtag|
            faq.hashtags << Hashtag.create!(name: hashtag, company: @company)
          end
          "Created with success!"
        end
      rescue => e
        "Ops! I'm sorry, but during the process of Faq creation occurred error #{e}. Contact us to resolve this problem! We will be glad to help you!"
      end
    end

  end

end
