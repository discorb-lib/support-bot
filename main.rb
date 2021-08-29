require "discorb"
require_relative "exts/eval"
require_relative "exts/dispander"
require_relative "exts/no_hoist"

require "dotenv"

Dotenv.load

client = Discorb::Client.new(intents: Discorb::Intents.all)

client.extend(Evaler)
client.extend(Dispander)
client.extend(NoHoist)

client.run(ENV["TOKEN"])
