require 'json'
class Response
  class << self
    def response_ok
      return {response: :ok}
    end
  end
end