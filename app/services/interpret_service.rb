module InterpretService
  def self.call action, params
    case action
    when "list", "search", "search_by_hashtag"
      FaqModule::ListService.new(params,action).call()
    when "create"
      FaqModule::CreateService.new(params).call()
    else
      "Não compreendi seu desejo.Pode repetir por favor?"
    end
  end
end
