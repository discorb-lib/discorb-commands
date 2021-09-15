module Discorb::Commands
  class Error < ::StandardError
  end

  #
  # Raised when failed to parse arguments.
  #
  class ParseError < Error
  end

  #
  # Raised when a command is not found.
  #
  class CommandNotFound < Error
  end
end
