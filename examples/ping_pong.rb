require "discorb"
require "discorb/commands"

client = Discorb::Client.new

client.extend(Discorb::Commands::Main)

client.command "ping" do |ctx|
  ctx.reply "pong"
end

client.run
