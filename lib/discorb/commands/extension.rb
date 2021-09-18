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
      real_prefixes = @client.prefix.is_a?(Proc) ? @client.prefix.call(message) : @client.prefix
      real_prefixes = [real_prefixes] unless real_prefixes.is_a?(Array)
      prefix = prefixes.find { |prefix| message.start_with?(prefix) }
      return unless prefix  # If it wasn't command

      Discorb::Commands::Context.new(client, message, prefix).handle
    end

    def command(name, options = {}, &block)
      @commands[name] = {
        options: options,
        block: block,
      }
    end

    private

    def self.extended(base)
      base.commands = {}
      base.prefix = nil
      base.on :command_not_found do |message, name|
        message.reply("Command not found: #{name}")
      end
    end
  end
end
