require "discorb"
require_relative "exts/eval"
require_relative "exts/dispander"
require_relative "exts/no_hoist"

require "dotenv"

Dotenv.load

client = Discorb::Client.new(intents: Discorb::Intents.all)

client.once :ready do
  puts "Logged in as #{client.user}"
end

client.extend(Evaler)
client.extend(Dispander)
client.extend(NoHoist)

client.run(ENV["TOKEN"])
