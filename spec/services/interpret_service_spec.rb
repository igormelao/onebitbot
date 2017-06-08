require_relative "./../spec_helper.rb"

describe InterpretService do
  before do
    @company = create(:company)
  end

  describe "#invalid action" do
    it "with invalid action must return message don't understand your ask" do
      response = InterpretService.call('invalid', {})

      expect(response).to match("Não compreendi seu desejo.Pode repetir por favor?")
    end
  end

  describe "#list" do
    it "with zero faqs, return don't find message" do
      response = InterpretService.call('list',{})

      expect(response).to match("Nada encontrado")
    end

    it "with two faqs, find questions and answer in response" do
      faq1 = create(:faq, company: @company)
      faq2 = create(:faq, company: @company)

      response = InterpretService.call('list', {})

      expect(response).to match(faq1.question)
      expect(response).to match(faq1.answer)
      expect(response).to match(faq2.question)
      expect(response).to match(faq2.answer)
      expect(response).not_to match("Nada encontrado")
    end
  end

  describe "#search" do
    it "with empty query must return message don't find message" do
      response = InterpretService.call('search', {"query" => ''})

      expect(response).to match("Nada encontrado")
    end

    it "with valid query must find and return question and answer in response" do
      faq = create(:faq, company: @company)
      termOfSearch = faq.question.split(" ").sample

      faq2 =create(:faq, question: "Another", answer: "hahaha", company: @company)

      response = InterpretService.call('search', {"query" => termOfSearch})

      expect(response).to match(faq.question)
      expect(response).to match(faq.answer)
      expect(response).not_to match(faq2.question)
      expect(response).not_to match(faq2.answer)
    end
  end

  describe "#search by category" do
    it "with invalid hastag must return message don't find message" do
      response = InterpretService.call("search_by_hashtag", {"query" => ""})

      expect(response).to match("Nada encontrado")
    end

    it "with valid hashtag must find and return question and answer in response" do
      faq = create(:faq, company: @company)
      hashtag = create(:hashtag, company: @company)
      create(:faq_hashtag, faq: faq, hashtag: hashtag)

      response = InterpretService.call('search_by_hashtag', {"query" => hashtag.name})

      expect(response).to match(faq.question)
      expect(response).to match(faq.answer)
    end
  end

  describe "#create" do
    before do
      @question = FFaker::Lorem.sentence
      @answer = FFaker::Lorem.sentence
      @hashtags = "#{FFaker::Lorem.word},#{FFaker::Lorem.word}"
    end

    it "without hashtag params must return a error" do
      response = InterpretService.call("create", {
                                                  'question-original' => @question,
                                                  'answer-original'   => @answer
                                                  })
      expect(response).to match("Hashtag is required!")
    end

    it "with valid params must receive success message" do
      response = InterpretService.call('create', {'question-original' => @question,
                                                  'answer-original'   => @answer,
                                                  'hashtags-original' => @hashtags
                                                 })
      expect(response).to match("Created with success!")
    end

    it "with valid params must receive success message" do
      response = InterpretService.call('create', {'question-original' => @question,
                                                  'answer-original'   => @answer,
                                                  'hashtags-original' => @hashtags
                                                 })
      expect(Faq.last.question).to match(@question)
      expect(Faq.last.answer).to match(@answer)
    end

    it "with valid params, hashtags are created" do
      response = InterpretService.call('create', {'question-original' => @question,
                                                  'answer-original'   => @answer,
                                                  'hashtags-original' => @hashtags
                                                 })
      expect(@hashtags.split(/[\s,]+/).first).to match(Hashtag.first.name)
      expect(@hashtags.split(/[\s,]+/).last).to match(Hashtag.last.name)
    end
  end

  describe "#remove" do

    it "with valid ID, remove FAQ" do
      faq = create(:faq, company: @company)

      response = InterpretService.call('remove', {"id" => faq})

      expect(response).to match("Deletado com sucesso")
    end

    it "with invalid id must return message error" do
      response = InterpretService.call('remove', {"id" => rand(1..9999)})

      expect(response).to match("Questão inválida, por favor verifique o Id")
    end
  end

  describe "#help" do
    it "with valid command must return options" do
      response = InterpretService.call('help', {})

      expect(response).to match('help')
      expect(response).to match('Adicione ao Faq')
      expect(response).to match('Remova ID')
      expect(response).to match('O que você sabe sobre X')
      expect(response).to match('Pesquise a hashtag X')
      expect(response).to match('Perguntas e Respostas')
    end
  end
end
