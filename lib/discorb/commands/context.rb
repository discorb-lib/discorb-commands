module Discorb::Commands
  class Context
    def initialize(client, message, prefix)
      @client = client
      @prefix = prefix
    end
  end
end