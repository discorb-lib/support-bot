require "discorb"
require "dotenv"

Dotenv.load

client = Discorb::Client.new(log: File.open("./out.log", "w"), log_level: :debug, intents: Discorb::Intents.all)

client.once :standby do
  puts "Logged in as #{client.user}"
end

load "./exts/auto_role.rb"
load "./exts/eval.rb"
load "./exts/dispander.rb"
load "./exts/no_hoist.rb"
client.extend(AutoRole)
client.extend(Evaler)
client.extend(Dispander)
client.extend(NoHoist)

client.run(ENV["TOKEN"])
