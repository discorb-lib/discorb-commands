module Discorb::Commands
  module Main
    extend Discorb::Extension

    # @return [String, Array<String>, Proc] The prefixes to use for the commands.
    attr_accessor :prefix
    attr_accessor :commands

    once_event :ready do
      raise "No prefix set" unless @client.prefix
    end

    event :message do |message|
      real_prefix = @client.prefix.is_a?(Proc) ? @client.prefix.call(message) : @client.prefix
      real_prefix = [real_prefix] unless real_prefix.is_a?(Array)
      if message.content.start_with?(*real_prefix)
        @client.handle_command(message, message.content.delete_prefix(*real_prefix))
      end
    end

    def command(name, options = {}, &block)
      @commands[name] = {
        options: options,
        block: block,
      }
    end

    def handle_command(message, content)
      splited_content = content.scan(/((?:\w|(["'])[^\2]*\2)+)/).map(&:first)
      if splited_content.join(" ") != content
        raise Discorb::Commands::ParseError, "Invalid command syntax"
      end
      pp splited_content
    end

    private

    def self.extended(base)
      base.commands = {}
      base.prefix = nil
    end
  end
end
